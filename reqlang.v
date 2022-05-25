module main


/* Using net.http for now, will write my own http client later */
// import net.http
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
		parser.transpile(text)
	}
}
	app.setup()
	app.parse(os.args)

}
