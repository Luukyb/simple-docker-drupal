<?php

/**
 * @file
 * Local Drupal site-specific configuration file.
 */

/*
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

/*
 * Variable overrides.
 */
$conf['drupal_http_request_fails'] = FALSE;
$conf['smtp_on'] = 0;
$conf['smtp_password'] = '';
$conf['googleanalytics_account'] = 'UA-11111111-1';

/*
 * Redis settings.
 */
$conf['redis_client_interface'] = 'PhpRedis';
$conf['redis_client_host'] = 'redis';
$conf['redis_client_port'] = '6379';
$conf['cache_backends'][] = 'sites/all/modules/contrib/redis/redis.autoload.inc';

/*
 * Apache Solr settings.
 */
$conf['apachesolr_environments']['solr']['url'] = 'http://solr.drupal.dev:8983/solr/mycore';
