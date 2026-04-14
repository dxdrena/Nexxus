<?php

function getBinInfo($cc) {
    $bin = substr($cc, 0, 6);

    $url = "https://lookup.binlist.net/" . $bin;

    $ch = curl_init();
    curl_setopt($ch, CURLOPT_URL, $url);
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
    curl_setopt($ch, CURLOPT_TIMEOUT, 10);
    curl_setopt($ch, CURLOPT_HTTPHEADER, [
        "Accept-Version: 3"
    ]);

    $response = curl_exec($ch);
    curl_close($ch);

    if (!$response) {
        return [
            'bin' => $bin,
            'brand' => 'UNKNOWN',
            'type' => 'UNKNOWN',
            'bank' => 'UNKNOWN',
            'country' => 'UNKNOWN'
        ];
    }

    $data = json_decode($response, true);

    return [
        'bin' => $bin,
        'brand' => $data['scheme'] ?? 'UNKNOWN',
        'type' => $data['type'] ?? 'UNKNOWN',
        'bank' => $data['bank']['name'] ?? 'UNKNOWN',
        'country' => $data['country']['name'] ?? 'UNKNOWN'
    ];
}

function formatarBinStr($binInfo) {
    return strtoupper(
        ($binInfo['brand'] ?? 'UNKNOWN') . ' ' .
        ($binInfo['type'] ?? '') . ' ' .
        ($binInfo['bank'] ?? '') . ' ' .
        ($binInfo['country'] ?? '')
    );
}