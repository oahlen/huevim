use clap::Parser;

#[derive(Debug, Parser)]
#[clap(author, version, about)]
pub struct Args {
    /// The input colorscheme file.
    pub filename: String,
    /// Directory of generated colorscheme, default to the current working directory.
    pub output: Option<String>,
    /// Overwrite the init.lua file if it already exists.
    #[clap(long)]
    pub overwrite_init: bool,
}
