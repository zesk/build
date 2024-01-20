#!/usr/bin/env php
<?php

use zesk\SimpleApplication\Application;

require_once dirname(__DIR__) . '/simple.application.php';

Application::writeCronEnvironment();
