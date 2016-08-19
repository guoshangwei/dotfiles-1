# Ref:
#   https://github.com/robbyrussell/oh-my-zsh/blob/master/plugins/ssh-agent/ssh-agent.plugin.zsh
#   https://github.com/robbyrussell/oh-my-zsh/blob/master/plugins/gpg-agent/gpg-agent.plugin.zsh

[[ -n "$HOST" ]] || HOST="$(hostname)"
_plugin__ssh_env="$HOME/.ssh/ssh-agent-$HOST.env"
_plugin__gpg_env="$HOME/.gnupg/gpg-agent-$HOST.env"

function _plugin__ssh_agent_running()
{
    # ssh-add -l exit code: 0 agent running, 1 agent running without key, 2 not running
    [[ -n "$SSH_AUTH_SOCK" && "$(/usr/bin/env ssh-add -l &>/dev/null; echo $?)" -ne 2 ]]
}

function _plugin__gpg_agent_running()
{
    [[ -n "$GPG_AGENT_INFO" ]] && /usr/bin/env gpg-connect-agent --quiet /bye &>/dev/null
}

function _plugin__start_ssh_agent()
{
    echo starting ssh-agent...

    # start ssh-agent and setup environment
    (umask 0077; /usr/bin/env ssh-agent | sed 's/^echo/#echo/' > "${_plugin__ssh_env}")
    chmod 600 "${_plugin__ssh_env}"
    . "${_plugin__ssh_env}" > /dev/null

    # load identies
    /usr/bin/env ssh-add
}

function _plugin__start_gpg_agent()
{
    echo starting gpg-agent...

    # start gpg-agent and setup environment
    (umask 0077; /usr/bin/env gpg-agent --quiet --daemon --write-env-file "${_plugin__gpg_env}" > /dev/null)
    chmod 600 "${_plugin__gpg_env}"
    . "${_plugin__gpg_env}" > /dev/null
    export GPG_AGENT_INFO
}

if ! _plugin__ssh_agent_running; then
    if [[ -f "${_plugin__ssh_env}" ]]; then
        . "${_plugin__ssh_env}" > /dev/null
    fi

    if ! _plugin__ssh_agent_running; then
        _plugin__start_ssh_agent
    fi
fi

if ! _plugin__gpg_agent_running; then
    if [[ -f "${_plugin__gpg_env}" ]]; then
        . "${_plugin__gpg_env}" > /dev/null
        export GPG_AGENT_INFO
    fi

    if ! _plugin__gpg_agent_running; then
        _plugin__start_gpg_agent
    fi
fi

GPG_TTY="$(tty)"
export GPG_TTY

# cleanup
unset -f _plugin__ssh_agent_running
unset -f _plugin__gpg_agent_running
unset -f _plugin__start_ssh_agent
unset -f _plugin__start_gpg_agent
unset _plugin__ssh_env
unset _plugin__gpg_env
