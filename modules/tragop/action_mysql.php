<?php

if (!defined('NV_IS_FILE_MODULES')) {
    die('Stop!!!');
}

$sql_drop_module = [];
$sql_drop_module[] = "DROP TABLE IF EXISTS " . $db_config['prefix'] . "_" . $lang . "_" . $module_data . "_orders;";

$sql_create_module = $sql_drop_module;
$sql_create_module[] = "CREATE TABLE " . $db_config['prefix'] . "_" . $lang . "_" . $module_data . "_orders (
  id int(11) unsigned NOT NULL AUTO_INCREMENT,
  customer_name varchar(255) NOT NULL DEFAULT '',
  customer_phone varchar(20) NOT NULL DEFAULT '',
  laptop_name varchar(255) NOT NULL DEFAULT '',
  laptop_price bigint(20) unsigned NOT NULL DEFAULT '0',
  prepay_percent tinyint(3) unsigned NOT NULL DEFAULT '0',
  months tinyint(3) unsigned NOT NULL DEFAULT '0',
  monthly_payment bigint(20) unsigned NOT NULL DEFAULT '0',
  created_at int(11) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (id)
) ENGINE=MyISAM;";
