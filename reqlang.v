module main

import parser
import cli 
import os



fn main() {
	mut app := cli.Command{
	name: "reqlang"
	description: "The reqlang interpreter written in V"
	execute: fn (cmd cli.Command) ? {
		mut file := cmd.args[0] or {
			println("No file specified")
			exit(-1)
		}
		println("Compiling $file to V...")
		mut text := os.read_file(file) ?
		mut transpiled := parser.transpile(text)
		os.write_file("out.v", transpiled) or {
			println("Failed to write file")
			exit(-1)
		}
	}
}
	app.setup()
	app.parse(os.args)
}
