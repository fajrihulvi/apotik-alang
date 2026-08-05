<?php
defined('BASEPATH') OR exit('No direct script access allowed');

$active_group = 'default';
$query_builder = TRUE;
$active_record = TRUE;//ci version 2.x

/*
| -------------------------------------------------------------------
| KONFIGURASI DATABASE PER ENVIRONMENT
| -------------------------------------------------------------------
|
| Environment ditentukan oleh $_SERVER['CI_ENV'] di index.php.
| Default-nya 'development' (XAMPP lokal). Di server production,
| set CI_ENV=production lewat .htaccess:
|
|     SetEnv CI_ENV production
|
| Kredensial production sebaiknya ditaruh di file terpisah
| application/config/db_credentials.php yang tidak ikut ke git.
| Bila file itu tidak ada, nilai default di bawah yang dipakai.
|
*/

$db_credentials_file = APPPATH.'config/db_credentials.php';
$db_credentials = file_exists($db_credentials_file) ? include $db_credentials_file : array();

if (ENVIRONMENT === 'production') {

    $db_host = isset($db_credentials['hostname']) ? $db_credentials['hostname'] : 'localhost';
    $db_user = isset($db_credentials['username']) ? $db_credentials['username'] : 'u822118421_alang';
    $db_pass = isset($db_credentials['password']) ? $db_credentials['password'] : '1kQ:nS^P0';
    $db_name = isset($db_credentials['database']) ? $db_credentials['database'] : 'u822118421_alang';

} else {

    // XAMPP lokal
    $db_host = 'localhost';
    $db_user = 'root';
    $db_pass = '';
    $db_name = 'apotik_alang_new';
}

$db['default'] = array(
    'dsn'   => '',
    'hostname' => $db_host,
    'username' => $db_user,
    'password' => $db_pass,
    'database' => $db_name,
    'dbdriver' => 'mysqli',
    'dbprefix' => '',
    'pconnect' => FALSE,
    'db_debug' => (ENVIRONMENT !== 'production'),
    'cache_on' => FALSE,
    'cachedir' => '',
    'char_set' => 'utf8',
    'dbcollat' => 'utf8_general_ci',
    'swap_pre' => '',
    'encrypt'  => FALSE,
    'compress' => FALSE,
    'autoinit' => TRUE,//ci version 2.x
    'stricton' => FALSE,
    'failover' => array(),
    'save_queries' => TRUE
);
