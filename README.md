
![](https://giacomo270197.github.io/assets/panda/images/panda_logo.jpeg)


# Panda

Panda is a programming language created with Windows shellcode in mind. The compiler builds a completely position-independent assembly which is then assembled with Keystone engine. Lark is used for parsing the EBFN grammar and creating the AST.  
The language is strongly typed, but type checking is quite relaxed and allows for a high degree of flexibility needed for shellcode development. The syntax is in general similar to C and Go. The idea for the language was inspired by the OSED course I recently took.  
I wanted to develop a way to write custom shellcode that would not require the user to write Assembly directly and bother with shellcode specific programming techniques.

# Usage

Every Panda compiled program must contain exactly one `main` function, which is the entrypoint for the custom code.  
Windows API functions can be declared with the `declare` command, and other Panda source code files can be imported with the `import` statement.  
The `panda_compile.py` script acts as the compiler user interface.  
The script takes a mandatory `--source` parameter which should point to the Panda source code file to compile.  
Moreover, at least one of the following flags must be set as well:
- `--asm`: Outputs the result in a `.asm` file which contains the generated Assembly.
- `--bin`: Outputs the compiled result in a raw binary file.
- `--py`: Outputs the result in a Python byte array format.
- `--test`: Doesn't output anything, but injects the code in the current process space and runs it. Make sure you are running the correct Python executable if testing (32 bits for 32 bits shellcode).

There are also debugging flags available, `--debug_tree` prints the parsed grammar as a tree, and `--debug_asm` prints the generated assembly.



# State of development

Panda currently only supports X86 architecture, 32 bits. At the time being the language is mostly functional and comes with a growing standard library, also written in Panda so that it can be shared across architectures.  
The compilation is still somewhat fragile. If some combination of commands doesn't work, a more explicit version just might.

# Upcoming features

In no particular order, these are the features I am planning on adding to the language:

- Improving the post-processor for the 32-bits compiler. Mainly removing unused functions (!!) and unnecessary Assembly instructions.
- Adding a function wrapper that would allow for getting an address of a function. Useful for multithreaded shellcode and for injecting code.
- Expanding the standard library. More process related functions, network protocols, shells, injection techniques, ...
- Improving compilation, especially making it less prone to breaking.
- Implementing a X86-64 compiler.

# Docs

Documentation can be found at https://giacomo270197.github.io/panda