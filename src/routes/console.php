<?php

use Illuminate\Foundation\Inspiring;

/*
|--------------------------------------------------------------------------
| Console Routes
|--------------------------------------------------------------------------
|
| This file is where you may define all of your Closure based console
| commands. Each Closure is bound to a command instance allowing a
| simple approach to interacting with each command's IO methods.
|
*/

Artisan::command('inspire', function () {
    $this->comment(Inspiring::quote());
})->describe('Display an inspiring quote');

Artisan::command('cron-test', function () {
    app('log')->info('Starting cron test, sleeping for 80 seconds ' . \Carbon\Carbon::now()->toIso8601String());
    sleep(80);
    app('log')->info('Ending cron test' . \Carbon\Carbon::now()->toIso8601String());
})->describe('Demonstrate an overlapping cron');
