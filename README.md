# finite-state-semantics
Finite state possible world semantics using FOMA

# Installation and Usage

Using this code requires the foma finite-state toolkit, which is available
[here](https://github.com/mhulden/foma/tree/master/foma "Foma on GitHub"). Foma
is also available in the official repositories of recent versions of Ubuntu and
some other Linux distros, and can be installed via `apt-get` or other package
managers. For example, on Ubuntu:

    $ sudo apt-get install foma-bin

To use the SetHack code, a special version of foma is needed to make iteration
easier (and complex visualization possible). This version is available
[here](https://github.com/thorsonlinguistics/semantic-foma "Semantic Foma"). 

Once you have foma installed, it can be invoked to read and interact with the
models. The `source` command loads a file from disk into foma.

    $ foma
    (some text will appear here)
    foma[0]: source rooth.fst
    (some more text)
    foma[0]: regex Example11;
    3.3 kB. 78 states, 169 arcs, 3648 paths.
    foma[1]: view
    foma[1]: print dot > example11.dot
    foma[1]: exit

The `view` command opens up a graphics window that displays the FSM. This
requires the appropriate packages to be installed, depending on your system
(see the [foma GitHub page](https://github.com/mhulden/foma/tree/master/foma
"Foma on GitHub") for more details). 

To use the SetHack module, navigate to the `sethack` directory and invoke foma.
The `main.fst` file contains main "program" and runs all of the necessary
modules in the proper order. The `DisplayLevelSimple` macro can be used to
create simpler visualizations of the worlds. The `print words` commands will
then print the worlds in order; `random-words` will print a random set of
worlds. Not that the command is `print words` and not `print WORLDS`.

    $ foma
    (...)
    foma[0]: source main.fst
    (...)
    foma[0]: regex FelineCorner;
    20.5 MB. 281281 states, 1342811 arcs, Cyclic.
    foma[1]: regex DisplayLevelSimple(TrueWorlds(FelineCorner));
    349.5 kB. 319 states, 21234 arcs, mroe than 9223372036854775807 paths.
    foma[2]: print words
    fffff
    fffff
    fffff
    fffff
    fffff

    fffff
    fffff
    fffff
    fffff
    ffffa

    fffff
    fffff
    fffff
    fffff
    ffffb

    fffff
    fffff
    fffff
    fffff
    ffffc

    fffff
    fffff
    fffff
    fffff
    ffffd
    (more worlds may appear)
    foma[2]: random-words
    [1]
    f'g)q
    ZgztT
    Jni⌠`
    ym`p&
    y?![s

    [1]
    fuBn(
    t>\$>
    EyYVV
    @pY0B
    Mq⌠+&
    (more and different worlds may appear)
    foma[2]: exit
