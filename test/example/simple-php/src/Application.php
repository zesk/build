<?php

namespace zesk\SimpleApplication;

use ErrorException;

class Application {
	/**
	 *
	 * @return string
	 * @throws ErrorException
	 */
	private static function cacheDirectory(): string
	{
		$rootDir = dirname(__DIR__);
		$cacheDir = $rootDir . '/cache';

		if (!is_dir($cacheDir)) {
			if (!mkdir($cacheDir, 0700)) {
				throw new ErrorException("Can not create cache: $cacheDir");
			}
		}
		return $cacheDir;
	}

	/**
	 *
	 * @return string
	 * @throws ErrorException
	 */
	private static function cronEnvironmentPath(): string
	{
		return self::namedEnvironmentPath("cron");
	}

	/**
	 *
	 * @return string
	 * @throws ErrorException
	 */
	private static function serviceEnvironmentPath(): string
	{
		return self::namedEnvironmentPath("service");
	}

	/**
	 * @param string $prefix
	 * @return string
	 * @throws ErrorException
	 */
	private static function namedEnvironmentPath(string $prefix): string
	{
		return self::cacheFilePath("$prefix-env.json");
	}

	/**
	 * @param string $name
	 * @return string
	 * @throws ErrorException
	 */
	private static function cacheFilePath(string $name): string
	{
		return self::cacheDirectory() . "/$name";
	}

	/**
	 *
	 * @return void
	 * @throws ErrorException
	 */
	public static function writeCronEnvironment(): void
	{
		self::writeEnvironment(self::PREFIX_CRON);
	}

	const PREFIX_CRON = "cron";
	const PREFIX_SERVICE = "service";

	/**
	 *
	 * @return void
	 * @throws ErrorException
	 */
	public static function writeServiceEnvironment(): void
	{
		self::writeEnvironment(self::PREFIX_SERVICE);
	}

	public static function unameSet(): array
	{
		return [
			'os' => php_uname('s'), 'name' => php_uname('n'), 'version' => php_uname('r'), 'all' => php_uname('v'),
			'arch' => php_uname('m'),
		];
	}

	/**
	 * @param string $prefix
	 * @return void
	 * @throws ErrorException
	 */
	private static function writeEnvironment(string $prefix, array $extras = []): void
	{
		$cacheDir = self::cacheDirectory();
		$firstFile = $cacheDir . "/$prefix-first";
		$now = time();
		if (!is_file($firstFile)) {
			$first = $now;
			file_put_contents($firstFile, $first);
		} else {
			$first = intval(file_get_contents($firstFile));
		}

		$data = ['firstRun' => $first, 'lastRun' => $now, 'uname' => self::unameSet()] + $extras + $_SERVER + $_ENV;
		file_put_contents(self::namedEnvironmentPath($prefix), json_encode($data, JSON_PRETTY_PRINT));
	}

	/**
	 * @return string[]
	 * @throws ErrorException
	 */
	private static function loadNamedEnvironment(string $prefix): array
	{
		$file = self::namedEnvironmentPath($prefix);
		if (!is_file($file)) {
			return ['error' => 'File-Not-Found'];
		}
		$result = json_decode(file_get_contents($file), true);
		if ($result === null) {
			return ['error' => 'JSON-Decode-Failed'];
		}
		return $result;
	}

	/**
	 * @return string[]
	 * @throws ErrorException
	 */
	public static function loadCronEnvironment(): array
	{
		return self::loadNamedEnvironment(self::PREFIX_CRON);
	}

	/**
	 * @return string[]
	 * @throws ErrorException
	 */
	public static function loadServiceEnvironment(): array
	{
		return self::loadNamedEnvironment(self::PREFIX_SERVICE);
	}

	private static function unquote($x)
	{
		$first = $x[0];
		$last = $x[strlen($x) - 1];
		if ($first === $last && $first === '"') {
			return strtr(substr($x, 1, -1), '\\"', '"');
		}
		return $x;
	}

	/**
	 * @return array|string[]
	 */
	public static function loadDotEnvironment(): array
	{
		$env = [];
		$envFile = dirname(__DIR__) . "/.env";
		if (file_exists($envFile)) {
			$file = file_get_contents($envFile);
			foreach (explode("\n", $file) as $line) {
				[$name, $value] = explode("=", $line, 2) + [null, null];
				$env[$name] = $value ? self::unquote($value) : null;
			}
			if (count($env) === 0) {
				$env['error'] = 'Empty-File';
			}
		} else {
			$env['error'] = 'File-Not-Found';
		}
		return $env;
	}

	/**
	 * @return string
	 * @throws ErrorException
	 */
	private static function serviceStatusFile(): string
	{
		return self::cacheDirectory() . "/service.json";
	}

	/**
	 * @return void
	 */
	public static function serviceLoop(): void
	{
		declare (ticks=1) {
			while (true) {
				$seconds = rand(1, 50);
				$filePath = self::serviceEnvironmentPath();
				if (is_file($filePath)) {
					$lastLog = "Wrote " . filesize(self::serviceEnvironmentPath()) . " bytes on " . date('Y-m-d H:i:s');
				} else {
					$lastLog = "Creating $filePath on " . date('Y-m-d H:i:s');
				}
				self::writeEnvironment(self::PREFIX_SERVICE, ['nextDelay' => $seconds, 'lastLog' => $lastLog]);
				echo($lastLog . "\n");
				usleep($seconds * 1000000);
			}
		}
	}
}
