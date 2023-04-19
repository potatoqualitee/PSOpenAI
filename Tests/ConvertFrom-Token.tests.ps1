﻿#Requires -Modules @{ ModuleName="Pester"; ModuleVersion="5.3.0" }

BeforeAll {
    $script:ModuleRoot = Split-Path $PSScriptRoot -Parent
    $script:ModuleName = 'PSOpenAI'
    $script:TestData = Join-Path $PSScriptRoot 'TestData'
    Import-Module (Join-Path $script:ModuleRoot "$script:ModuleName.psd1") -Force
}

Describe 'ConvertFrom-Token' {
    Context 'Unit tests (offline)' -Tag 'Offline' {
        BeforeEach {
            $script:Result = $null
        }

        It 'Encoding: cl100k_base (<Id>)' -Foreach @(
            @{ Id = 1; Text = ''; Token = @() }
            @{ Id = 2; Text = 'a'; Token = , 64 }
            @{ Id = 3; Text = 'Hello, World! How are you today? 🌍'; Token = (9906, 11, 4435, 0, 2650, 527, 499, 3432, 30, 11410, 234, 235) }
            @{ Id = 4; Text = 'こんにちは、世界！お元気ですか？'; Token = (90115, 5486, 3574, 244, 98220, 6447, 33334, 24186, 95221, 38641, 32149, 11571) }
            @{ Id = 5; Text = 'Здравствуйте, это мой первый раз здесь. Что мне делать?'; Token = (36551, 7094, 28086, 20812, 83680, 51627, 11, 68979, 11562, 16742, 77901, 35723, 39479, 11122, 7094, 92691, 13, 1301, 100, 25657, 11562, 79862, 95369, 18482, 30) }
            @{ Id = 6; Text = '🍏🍎🍐🍊🍋🍌🍉🍇🍓🍈🍒🍑'; Token = (9468, 235, 237, 9468, 235, 236, 9468, 235, 238, 9468, 235, 232, 9468, 235, 233, 9468, 235, 234, 9468, 235, 231, 9468, 235, 229, 9468, 235, 241, 9468, 235, 230, 9468, 235, 240, 9468, 235, 239) }
        ) {
            ConvertFrom-Token -Token $Token -Encoding 'cl100k_base' | Should -Be $Text
        }

        It 'Encoding: p50k_base (<Id>)' -Foreach @(
            @{ Id = 1; Text = ''; Token = @() }
            @{ Id = 2; Text = 'a'; Token = , 64 }
            @{ Id = 3; Text = 'Hello, World! How are you today? 🌍'; Token = (15496, 11, 2159, 0, 1374, 389, 345, 1909, 30, 12520, 234, 235) }
            @{ Id = 4; Text = 'こんにちは、世界！お元気ですか？'; Token = (46036, 22174, 28618, 2515, 94, 31676, 23513, 10310, 244, 45911, 234, 171, 120, 223, 2515, 232, 17739, 225, 36365, 245, 30640, 33623, 27370, 171, 120, 253) }
            @{ Id = 5; Text = 'Здравствуйте, это мой первый раз здесь. Что мне делать?'; Token = (140, 245, 43666, 21169, 16142, 38857, 21727, 20375, 38857, 35072, 140, 117, 20375, 16843, 11, 220, 141, 235, 20375, 15166, 12466, 120, 25443, 117, 12466, 123, 16843, 21169, 38857, 45035, 140, 117, 220, 21169, 16142, 140, 115, 12466, 115, 43666, 16843, 21727, 45367, 13, 12466, 100, 20375, 15166, 12466, 120, 22177, 16843, 12466, 112, 16843, 30143, 16142, 20375, 45367, 30) }
            @{ Id = 6; Text = '🍏🍎🍐🍊🍋🍌🍉🍇🍓🍈🍒🍑'; Token = (8582, 235, 237, 8582, 235, 236, 8582, 235, 238, 8582, 235, 232, 8582, 235, 233, 8582, 235, 234, 8582, 235, 231, 8582, 235, 229, 8582, 235, 241, 8582, 235, 230, 8582, 235, 240, 8582, 235, 239) }
        ) {
            ConvertFrom-Token -Token $Token -Encoding 'p50k_base' | Should -Be $Text
        }

        It 'Encoding: p50k_edit (<Id>)' -Foreach @(
            @{ Id = 1; Text = ''; Token = @() }
            @{ Id = 2; Text = 'a'; Token = , 64 }
            @{ Id = 3; Text = 'Hello, World! How are you today? 🌍'; Token = (15496, 11, 2159, 0, 1374, 389, 345, 1909, 30, 12520, 234, 235) }
            @{ Id = 4; Text = 'こんにちは、世界！お元気ですか？'; Token = (46036, 22174, 28618, 2515, 94, 31676, 23513, 10310, 244, 45911, 234, 171, 120, 223, 2515, 232, 17739, 225, 36365, 245, 30640, 33623, 27370, 171, 120, 253) }
            @{ Id = 5; Text = 'Здравствуйте, это мой первый раз здесь. Что мне делать?'; Token = (140, 245, 43666, 21169, 16142, 38857, 21727, 20375, 38857, 35072, 140, 117, 20375, 16843, 11, 220, 141, 235, 20375, 15166, 12466, 120, 25443, 117, 12466, 123, 16843, 21169, 38857, 45035, 140, 117, 220, 21169, 16142, 140, 115, 12466, 115, 43666, 16843, 21727, 45367, 13, 12466, 100, 20375, 15166, 12466, 120, 22177, 16843, 12466, 112, 16843, 30143, 16142, 20375, 45367, 30) }
            @{ Id = 6; Text = '🍏🍎🍐🍊🍋🍌🍉🍇🍓🍈🍒🍑'; Token = (8582, 235, 237, 8582, 235, 236, 8582, 235, 238, 8582, 235, 232, 8582, 235, 233, 8582, 235, 234, 8582, 235, 231, 8582, 235, 229, 8582, 235, 241, 8582, 235, 230, 8582, 235, 240, 8582, 235, 239) }
        ) {
            ConvertFrom-Token -Token $Token -Encoding 'p50k_edit' | Should -Be $Text
        }

        It 'Encoding: r50k_base (<Id>)' -Foreach @(
            @{ Id = 1; Text = ''; Token = @() }
            @{ Id = 2; Text = 'a'; Token = , 64 }
            @{ Id = 3; Text = 'Hello, World! How are you today? 🌍'; Token = (15496, 11, 2159, 0, 1374, 389, 345, 1909, 30, 12520, 234, 235) }
            @{ Id = 4; Text = 'こんにちは、世界！お元気ですか？'; Token = (46036, 22174, 28618, 2515, 94, 31676, 23513, 10310, 244, 45911, 234, 171, 120, 223, 2515, 232, 17739, 225, 36365, 245, 30640, 33623, 27370, 171, 120, 253) }
            @{ Id = 5; Text = 'Здравствуйте, это мой первый раз здесь. Что мне делать?'; Token = (140, 245, 43666, 21169, 16142, 38857, 21727, 20375, 38857, 35072, 140, 117, 20375, 16843, 11, 220, 141, 235, 20375, 15166, 12466, 120, 25443, 117, 12466, 123, 16843, 21169, 38857, 45035, 140, 117, 220, 21169, 16142, 140, 115, 12466, 115, 43666, 16843, 21727, 45367, 13, 12466, 100, 20375, 15166, 12466, 120, 22177, 16843, 12466, 112, 16843, 30143, 16142, 20375, 45367, 30) }
            @{ Id = 6; Text = '🍏🍎🍐🍊🍋🍌🍉🍇🍓🍈🍒🍑'; Token = (8582, 235, 237, 8582, 235, 236, 8582, 235, 238, 8582, 235, 232, 8582, 235, 233, 8582, 235, 234, 8582, 235, 231, 8582, 235, 229, 8582, 235, 241, 8582, 235, 230, 8582, 235, 240, 8582, 235, 239) }
        ) {
            ConvertFrom-Token -Token $Token -Encoding 'r50k_base' | Should -Be $Text
        }

        It 'Encoding: gpt2 (<Id>)' -Foreach @(
            @{ Id = 1; Text = ''; Token = @() }
            @{ Id = 2; Text = 'a'; Token = , 64 }
            @{ Id = 3; Text = 'Hello, World! How are you today? 🌍'; Token = (15496, 11, 2159, 0, 1374, 389, 345, 1909, 30, 12520, 234, 235) }
            @{ Id = 4; Text = 'こんにちは、世界！お元気ですか？'; Token = (46036, 22174, 28618, 2515, 94, 31676, 23513, 10310, 244, 45911, 234, 171, 120, 223, 2515, 232, 17739, 225, 36365, 245, 30640, 33623, 27370, 171, 120, 253) }
            @{ Id = 5; Text = 'Здравствуйте, это мой первый раз здесь. Что мне делать?'; Token = (140, 245, 43666, 21169, 16142, 38857, 21727, 20375, 38857, 35072, 140, 117, 20375, 16843, 11, 220, 141, 235, 20375, 15166, 12466, 120, 25443, 117, 12466, 123, 16843, 21169, 38857, 45035, 140, 117, 220, 21169, 16142, 140, 115, 12466, 115, 43666, 16843, 21727, 45367, 13, 12466, 100, 20375, 15166, 12466, 120, 22177, 16843, 12466, 112, 16843, 30143, 16142, 20375, 45367, 30) }
            @{ Id = 6; Text = '🍏🍎🍐🍊🍋🍌🍉🍇🍓🍈🍒🍑'; Token = (8582, 235, 237, 8582, 235, 236, 8582, 235, 238, 8582, 235, 232, 8582, 235, 233, 8582, 235, 234, 8582, 235, 231, 8582, 235, 229, 8582, 235, 241, 8582, 235, 230, 8582, 235, 240, 8582, 235, 239) }
        ) {
            ConvertFrom-Token -Token $Token -Encoding 'gpt2' | Should -Be $Text
        }

        It 'Input from pipeline' {
            $script:Result = (9468, 235, 237, 9468, 235, 236, 9468, 235, 238, 9468, 235, 232, 9468, 235, 233, 9468, 235, 234, 9468, 235, 231, 9468, 235, 229, 9468, 235, 241, 9468, 235, 230, 9468, 235, 240, 9468, 235, 239) | ConvertFrom-Token
            $script:Result | Should -Be '🍏🍎🍐🍊🍋🍌🍉🍇🍓🍈🍒🍑'
        }
    }
}