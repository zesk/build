<?php

date_default_timezone_set('UTC');

function unquote($x)
{
	$first = $x[0];
	$last = $x[strlen($x) - 1];
	if ($first === $last && $first === '"') {
		return strtr(substr($x, 1, -1), '\\"', '"');
	}
	return $x;
}


$env = [];
$envFile = dirname(__DIR__) . "/.env";
if (file_exists($envFile)) {
	$file = file_get_contents($envFile);
	foreach (explode("\n", $file) as $line) {
		[$name, $value] = explode("=", $line, 2) + [null, null];
		$env[$name] = $value ? unquote($value) : null;
	}
} else {
	$env = ['error' => '.env not found;'];
}
