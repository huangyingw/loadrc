
git init \
    && $HOME/loadrc/gitrc/gcob.sh dev \
    ; $HOME/loadrc/gitrc/gdev.sh \
    ; $HOME/loadrc/bashrc/update_proj.sh \
    && git add . \
    && git add -f files.proj \
    && $HOME/loadrc/gitrc/g.sh \
    && ~/loadrc/gitrc/gclb.sh
