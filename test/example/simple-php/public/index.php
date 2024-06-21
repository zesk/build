<?php

/**
 *
 * Copyright &copy; 2024 Market Acumen, Inc.
 */

use zesk\SimpleApplication\Application;

require_once dirname(__DIR__) . '/simple.application.php';

$showDetails = false;
$env = Application::loadDotEnvironment();
$env['uname'] = Application::unameSet();

$debugKey = $_REQUEST['key'] ?? null;
$applicationKey = $env['APPLICATION_KEY'] ?? null;
if ($applicationKey && $debugKey && $applicationKey === $debugKey) {
	$showDetails = true;
}
function justKeys(array $array, array $keys): array
{
	$result = [];
	foreach ($keys as $key) {
		if ($array[$key] ?? null) {
			$result[$key] = $array[$key];
		}
	}
	return $result;
}

function addEnvironmentKeys(callable|array $method, bool $showDetails = false): array
{
	$baseKeys = [
		'error', 'lastRun', 'firstRun', 'HOST', 'nextDelay', 'lastLog', 'uname', 'APPLICATION_BUILD_DATE',
		'APPLICATION_TAG', 'APPLICATION_VERSION', 'FOO', 'TEST', 'DEVELOPMENT',
	];
	if ($showDetails) {
		$baseKeys = array_merge($baseKeys, ['HOME', 'TERM']);
	}
	try {
		$environment = is_array($method) ? $method : $method();
		$result = justKeys($environment, $baseKeys);
		if ($result['lastRun'] ?? null) {
			$result['lastElapsed'] = time() - $result['lastRun'];
		}
		if ($result['firstRun'] ?? null) {
			$result['firstElapsed'] = time() - $result['firstRun'];
		}
		if ($showDetails) {
			$result['keys'] = array_keys($environment);
		} else {
			$result['keyCount'] = count($environment);
			$result['uname'] = justKeys($result['uname'] ?? [], ['os', 'name', 'arch']);
		}
		return $result;
	} catch (Exception $e) {
		return ['error' => get_class($e)];
	}
}

$json = ['now' => date('Y-m-d H:i:s')] + ['cookies' => $_COOKIE];
$json['cron'] = addEnvironmentKeys(Application::loadCronEnvironment(...), $showDetails);
$json['service'] = addEnvironmentKeys(Application::loadServiceEnvironment(...), $showDetails);
$json['dot'] = addEnvironmentKeys($env, $showDetails);

header('Content-Type: application/json');

echo json_encode($json);
