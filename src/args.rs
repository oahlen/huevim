use lexopt::prelude::*;

const VERSION: &str = env!("CARGO_PKG_VERSION");

#[derive(Debug)]
pub struct Args {
    pub filename: String,
    pub output: Option<String>,
    pub overwrite_init: bool,
}

impl Args {
    pub fn parse() -> Result<Args, lexopt::Error> {
        let mut filename: Option<String> = None;
        let mut output: Option<String> = None;
        let mut overwrite_init = false;

        let mut parser = lexopt::Parser::from_env();
        while let Some(arg) = parser.next()? {
            match arg {
                Value(val) if filename.is_none() => {
                    filename = Some(val.string()?);
                }
                Value(val) if output.is_none() => {
                    output = Some(val.string()?);
                }
                Long("overwrite-init") => {
                    overwrite_init = true;
                }
                Short('h') | Long("help") => {
                    print_help();
                    std::process::exit(0);
                }
                Short('V') | Long("version") => {
                    println!("huevim {VERSION}");
                    std::process::exit(0);
                }
                _ => return Err(arg.unexpected()),
            }
        }

        Ok(Args {
            filename: filename.ok_or("Missing argument <FILENAME>")?,
            output,
            overwrite_init,
        })
    }
}

fn print_help() {
    println!("Neovim lua color scheme generator written in Rust.");
    println!();
    println!("Usage: huevim [OPTIONS] <FILENAME> [OUTPUT]");
    println!();
    println!("Arguments:");
    println!("  <FILENAME>  The input colorscheme file");
    println!(
        "  [OUTPUT]    Directory of generated colorscheme, default to the current working directory"
    );
    println!();
    println!("Options:");
    println!("      --overwrite-init  Overwrite the init.lua file if it already exists.");
    println!("  -h, --help            Print help information.");
    println!("  -V, --version         Print version information.");
}
