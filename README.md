# Hackasm

A Ruby-based compiler for the Hack platform developed in the scope of the NAND to Tetris course(parts [1](https://www.coursera.org/learn/nand2tetris) and [2](https://www.coursera.org/learn/nand2tetris2).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'hackasm'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install hackasm

## Usage

This tool is a translator that is aimed to translate code from the higher level programming language in the stack of Hack platform to the lower one. 

### `new` command

Translate *.asm file of assembler commands to *.hack file of binary commands. This command matches the project 7 and 9 of NAND to Tetris.


### `asm2binary`command

Translate *.vm file with virtual machine code or a folder of *.vm files to the single *.asm file of assembler commands. This command matches the project 6 of NAND to Tetris.

## Code of Conduct

Everyone interacting in the Hackasm project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/artur-martsinkovskyi/hackasm/blob/master/CODE_OF_CONDUCT.md).

## Copyright

Copyright (c) 2020 Artur Martsinkovskyi. See [MIT License](LICENSE.txt) for further details.
