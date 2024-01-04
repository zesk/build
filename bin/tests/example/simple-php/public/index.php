<?php
/**
 *
 * Copyright &copy; 2024 Market Acumen, Inc.
 */

require_once dirname(__DIR__) . '/simple.application.php';

$json = ['now' => date('Y-m-d H:i:s')];
foreach (['APPLICATION_BUILD_DATE', 'APPLICATION_TAG', 'APPLICATION_VERSION'] as $item) {
	$json[$item] = $env[$item] ?? null;
}
header('Content-Type: application/json');

echo json_encode($json);
