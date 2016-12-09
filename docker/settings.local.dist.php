<?php

/**
 * @file
 * Local Drupal site-specific configuration file.
 */

/**
 * Database settings.
 */
$databases = array(
  'default' =>
  array(
    'default' =>
    array(
      'database' => 'drupal',
      'username' => 'drupal',
      'password' => 'drupal',
      'host' => 'db.drupal.dev',
      'port' => '',
      'driver' => 'mysql',
      'prefix' => '',
    ),
  ),
);

/**
 * Variable overrides.
 */
$conf['drupal_http_request_fails'] = FALSE;
$conf['smtp_on'] = 0;
$conf['smtp_password'] = '';
$conf['googleanalytics_account'] = 'UA-11111111-1';
