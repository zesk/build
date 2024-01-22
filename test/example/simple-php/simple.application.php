<?php
/**
 * Simple application header
 *
 * Copyright &copy; 2024 Market Acumen, Inc.
 */
date_default_timezone_set('UTC');

if (!file_exists(__DIR__ . '/vendor/autoload.php')) {
	die("No vendor\n");
}

require_once __DIR__ . '/vendor/autoload.php';
