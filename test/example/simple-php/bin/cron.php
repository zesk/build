#!/usr/bin/env php
<?php
/*
 * Copyright &copy; 2024 Market Acumen, Inc.
 */
use zesk\SimpleApplication\Application;

require_once dirname(__DIR__) . '/simple.application.php';

Application::writeCronEnvironment();
