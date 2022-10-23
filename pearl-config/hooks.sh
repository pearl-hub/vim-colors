function post_install(){
    local pluginname=zenburn
    local giturl=https://github.com/jnurmine/Zenburn.git

    info "Installing or updating the $pluginname git repository..."
    local plugin_root="${PEARL_PKGVARDIR}/plugins/pack/pearl/start"
    mkdir -p "$plugin_root"
    install_or_update_git_repo $giturl "$plugin_root/$pluginname" master
    [[ -e "$plugin_root/$pluginname/doc" ]] && \
        vim -c "helptags $plugin_root/$pluginname/doc" -c q


    local pluginname=nord
    local giturl=https://github.com/arcticicestudio/nord-vim.git

    info "Installing or updating the $pluginname git repository..."
    local plugin_root="${PEARL_PKGVARDIR}/plugins/pack/pearl/start"
    mkdir -p "$plugin_root"
    install_or_update_git_repo $giturl "$plugin_root/$pluginname" main
    [[ -e "$plugin_root/$pluginname/doc" ]] && \
        vim -c "helptags $plugin_root/$pluginname/doc" -c q


    local pluginname=dracula
    local giturl=https://github.com/dracula/vim.git

    info "Installing or updating the $pluginname git repository..."
    local plugin_root="${PEARL_PKGVARDIR}/plugins/pack/pearl/start"
    mkdir -p "$plugin_root"
    install_or_update_git_repo $giturl "$plugin_root/$pluginname" master
    [[ -e "$plugin_root/$pluginname/doc" ]] && \
        vim -c "helptags $plugin_root/$pluginname/doc" -c q


    local pluginname=solarized
    local giturl=https://github.com/altercation/vim-colors-solarized.git

    info "Installing or updating the $pluginname git repository..."
    local plugin_root="${PEARL_PKGVARDIR}/plugins/pack/pearl/start"
    mkdir -p "$plugin_root"
    install_or_update_git_repo $giturl "$plugin_root/$pluginname" master
    [[ -e "$plugin_root/$pluginname/doc" ]] && \
        vim -c "helptags $plugin_root/$pluginname/doc" -c q

    local pluginname=gruvbox
    local giturl=https://github.com/morhetz/gruvbox.git

    info "Installing or updating the $pluginname git repository..."
    local plugin_root="${PEARL_PKGVARDIR}/plugins/pack/pearl/start"
    mkdir -p "$plugin_root"
    install_or_update_git_repo $giturl "$plugin_root/$pluginname" master
    [[ -e "$plugin_root/$pluginname/doc" ]] && \
        vim -c "helptags $plugin_root/$pluginname/doc" -c q

    local pluginname=gruvbox-material
    local giturl=https://github.com/sainnhe/gruvbox-material.git

    info "Installing or updating the $pluginname git repository..."
    local plugin_root="${PEARL_PKGVARDIR}/plugins/pack/pearl/start"
    mkdir -p "$plugin_root"
    install_or_update_git_repo $giturl "$plugin_root/$pluginname" master
    [[ -e "$plugin_root/$pluginname/doc" ]] && \
        vim -c "helptags $plugin_root/$pluginname/doc" -c q

    setup_configuration "${PEARL_PKGVARDIR}/vimrc" \
        _new_vimrc _apply_vimrc _unapply_vimrc

    return 0
}

function post_update(){
    post_install
}

function pre_remove(){
    _unapply_vimrc
    rm -rf "${PEARL_PKGVARDIR}/plugins"
}

_new_vimrc() {
    local themes=()
    local thm
    for thm in "$PEARL_PKGDIR/"vimrc-theme-*
    do
        themes+=($(basename "${thm/vimrc-theme-/}"))
    done

    local theme=$(choose "Which theme would you like?" "zenburn" "${themes[@]}")
    echo "set packpath+=$PEARL_PKGVARDIR/plugins" > "$PEARL_PKGVARDIR/vimrc"
    cat "$PEARL_PKGDIR/vimrc-theme-$theme" >> "$PEARL_PKGVARDIR/vimrc"
    return 0
}

_apply_vimrc() {
    link vim "$PEARL_PKGVARDIR/vimrc"

    return 0
}

_unapply_vimrc() {
    unlink vim "$PEARL_PKGVARDIR/vimrc"

    return 0
}

