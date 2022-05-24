module main


/* Using net.http for now, will write my own http client later */
// import net.http
import cli 
import os

fn main() {
	mut app := cli.Command{
		name: "reqlang"
		description: "The reqlang interpreter written in V"
		execute: fn (cmd cli.Command) ? {
			mut file := cmd.args[0]
			println(os.read_file(file) ?)
		}
	}
	app.setup()
	app.parse(os.args)
}
