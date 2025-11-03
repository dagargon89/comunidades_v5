<?php

return [

    /*
    |--------------------------------------------------------------------------
    | Third Party Services
    |--------------------------------------------------------------------------
    |
    | This file is for storing the credentials for third party services such
    | as Mailgun, Postmark, AWS and more. This file provides the de facto
    | location for this type of information, allowing packages to have
    | a conventional file to locate the various service credentials.
    |
    */

    'postmark' => [
        'token' => env('POSTMARK_TOKEN'),
    ],

    'resend' => [
        'key' => env('RESEND_KEY'),
    ],

    'ses' => [
        'key' => env('AWS_ACCESS_KEY_ID'),
        'secret' => env('AWS_SECRET_ACCESS_KEY'),
        'region' => env('AWS_DEFAULT_REGION', 'us-east-1'),
    ],

    'slack' => [
        'notifications' => [
            'bot_user_oauth_token' => env('SLACK_BOT_USER_OAUTH_TOKEN'),
            'channel' => env('SLACK_BOT_USER_DEFAULT_CHANNEL'),
        ],
    ],

    /*
    |--------------------------------------------------------------------------
    | Ollama AI Service Configuration
    |--------------------------------------------------------------------------
    |
    | Configuration for Ollama Cloud API used for generating narrative reports.
    | This service is used to automatically generate formal institutional
    | narratives from structured activity data.
    |
    */
    'ollama' => [
        'url' => env('OLLAMA_URL', 'http://localhost:11434'),
        'api_key' => env('OLLAMA_API_KEY'),
        'model' => env('OLLAMA_MODEL', 'llama3.1'),
        'timeout' => env('OLLAMA_TIMEOUT', 180),
        'temperature' => env('OLLAMA_TEMPERATURE', 0.3),
        'max_tokens' => env('OLLAMA_MAX_TOKENS', 1500),
    ],

];
