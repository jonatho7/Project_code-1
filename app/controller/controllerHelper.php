<?php
/**
 *
 *
 * Date: 11/22/14
 * Time: 4:51 PM
 *
 * This contains common code that will be used by views
 */

/*
 * encode region as query parameter if region is non null.
 */
function get_url_encode_region($region) {
    if (empty($region))
        return "";
    else {
        $array = array('region'=>$region);
        return http_build_query($array);
    }
}

/*
 * If "region" query parameter is not present,
 * then this will pick up default region from the Regions list.
 * Otherwise, returns whatever is passed.
 */

function getRegion($region) {

    if (!empty($region)) {
        return $region;
    } else {
        $region = Region::getFirstRegion();
        return $region;
    }
}