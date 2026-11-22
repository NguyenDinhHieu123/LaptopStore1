<?php

if (!defined('NV_IS_MOD_TRAGOP')) {
    die('Stop!!!');
}

function nv_theme_tragop_main($message = '')
{
    global $module_info, $lang_module, $module_file,$module_name, $op;

    $xtpl = new XTemplate($op . '.tpl', NV_ROOTDIR . '/themes/' . $module_info['template'] . '/modules/' . $module_file);
    $xtpl->assign('LANG', $lang_module);
    $xtpl->assign('FORM_ACTION', NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&amp;' . NV_NAME_VARIABLE . '=' . $module_name);

    if (!empty($message)) {
        $xtpl->assign('MESSAGE', $message);
        $xtpl->parse('main.message');
    }

    $xtpl->parse('main');
    return $xtpl->text('main');
}
