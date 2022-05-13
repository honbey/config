## brew

Add command to PATH and set options for compilers:

```bash
  # Homebrew
  export PATH="/opt/homebrew/bin:$PATH"
  # If you need to have openssl@1.1 first in your PATH, run:
  #  echo 'export PATH="/opt/homebrew/opt/openssl@1.1/bin:$PATH"' >> ~/.zshrc

  # For compilers to find openssl@1.1 you may need to set:
  #  export LDFLAGS="-L/opt/homebrew/opt/openssl@1.1/lib"
  #  export CPPFLAGS="-I/opt/homebrew/opt/openssl@1.1/include"
```

