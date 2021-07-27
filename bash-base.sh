#!/bin/bash

#    bash-base a simple text based data base script library
#    Copyright (C) 2021  lazypwny751
#
#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program.  If not, see <https://www.gnu.org/licenses/>.

bb_file_extention="bb"

bb-temp-manager() {
    case ${1} in
        start)
            [[ -d /tmp/bash-base ]] && rm -rf /tmp/bash-base
            mkdir -p /tmp/bash-base
        ;;
        stop)
            [[ -d /tmp/bash-base ]] && rm -rf /tmp/bash-base
        ;;
        *)
            echo "${FUNCNAME[0]}: Wrong usage, there are two (2) argument(s): start, stop"
            return 1
        ;;
    esac
}

bb-create-base() {
    bb_setdir="${PWD}"
    [[ $(command -v tar) ]] || { echo -e "\033[0;31mFatal: Command 'tar' Not Found\033[0m!" ; exit 1 ; }
    if ! [[ -z ${1} ]] && [[ $(echo "${1}" | grep " ") = "" ]] ; then
        bb-temp-manager start
        cd /tmp/bash-base
        mkdir "${1}" && cd "${1}"
        echo "bb_setbasename='${1}'" > metadata
        tar -czf "${bb_setdir}/${1}.${bb_file_extention}" ./*
        cd ${bb_setdir}
        bb-temp-manager stop
        return 0
    else
        echo "${FUNCNAME}: you need to specify the base name without escapes. Example: meraba-dunya"
        return 1
    fi

    if [[ ${#} -gt 1 ]] ; then
        echo "The ${FUNCNAME} must be needed 1 parametre."
        return 1
    fi
}

bb-create-tables() {
    bb_setdir="${PWD}"
    if [[ $(file "${1}" | grep "gzip compressed data") ]]  ; then
        if [[ ${#} -gt 1 ]] ; then
            bb-temp-manager start
            cp "${1}" /tmp/bash-base 
            cd /tmp/bash-base
            tar -xf "$(basename ${1})" && rm "$(basename ${1})"
            [[ -e ./metadata ]] && source ./metadata || { echo "metadata file not found in $(basename ${1})" ; return 1 ; } 
            for bb_create_table in $(seq 2 ${#}) ; do
                if ! [[ $(echo "${@:bb_create_table:1}" | grep " ") ]] ; then
                    if ! [[ -f "${@:bb_create_table:1}/data" ]] ; then
                        mkdir "${@:bb_create_table:1}" && echo "bb_index='NULL'" > "${@:bb_create_table:1}/data" 
                    else
                        echo "${@:bb_create_table:1}: already exist!"
                    fi
                else
                    echo "'${@:bb_create_table:1}': You can't use spaces in table name(s)!"
                fi
            done
            tar -czf "${bb_setdir}/${bb_setbasename}.${bb_file_extention}" ./*
            cd ${bb_setdir}
            bb-temp-manager stop
            return 0
        else
            echo "${FUNCNAME}: Please specify tables to create."
            return 1
        fi
    else
        echo "${FUNCNAME}: Please specify the base file as first parametre. Example: meraba-dunya.${bb_file_extention}"
        return 1
    fi
}

bb-check-table() {
    bb_setdir="${PWD}"
    if [[ $(file "${1}" | grep "gzip compressed data") ]]  ; then
        if [[ ! -z ${2} ]] ; then
            bb-temp-manager start
            cp "${1}" /tmp/bash-base 
            cd /tmp/bash-base
            tar -xf "$(basename ${1})" && rm "$(basename ${1})"
            if [[ -d "${2}" ]] ; then
                echo "Table '${2}' exist"
                cd ${bb_setdir}
                bb-temp-manager stop
                return 0
            else
                echo "Table '${2}' doesn't exist"
                cd ${bb_setdir}
                bb-temp-manager stop
                return 1
            fi
        else
            echo "${FUNCNAME}: Please specify the table name."
            return 1
        fi
    else
        echo "${FUNCNAME}: Please specify the base file as first parametre. Example: meraba-dunya.${bb_file_extention}"
        return 1
    fi
}

bb-remove-tables() {
    bb_setdir="${PWD}"
    if [[ $(file "${1}" | grep "gzip compressed data") ]]  ; then
        if [[ ${#} -gt 1 ]] ; then
            bb-temp-manager start
            cp "${1}" /tmp/bash-base 
            cd /tmp/bash-base
            tar -xf "$(basename ${1})" && rm "$(basename ${1})"
            [[ -e ./metadata ]] && source ./metadata || { echo "metadata file not found in $(basename ${1})" ; return 1 ; } 
            for bb_remove_table in $(seq 2 ${#}) ; do
                if ! [[ $(echo "${@:bb_remove_table:1}" | grep " ") ]] ; then
                    if [[ -f "${@:bb_remove_table:1}/data" ]] ; then
                        rm -rf "${@:bb_remove_table:1}" 
                    else
                        echo "${@:bb_remove_table:1}: Doesn't exist!"
                    fi
                else
                    echo "'${@:bb_remove_table:1}': You can't use spaces in table name(s)!"
                fi
            done
            tar -czf "${bb_setdir}/${bb_setbasename}.${bb_file_extention}" ./*
            cd ${bb_setdir}
            bb-temp-manager stop
            return 0
        else
            echo "${FUNCNAME}: Please specify tables to remove."
            cd ${bb_setdir}
            return 1
        fi
    else
        echo "${FUNCNAME}: Please specify the base file as first parametre. Example: meraba-dunya.${bb_file_extention}"
        return 1
    fi   
}

bb-index-table() {
    bb_setdir="${PWD}"
    if [[ $(file "${1}" | grep "gzip compressed data") ]]  ; then
        if [[ ! -z ${2} ]] ; then
            bb-temp-manager start
            cp "${1}" /tmp/bash-base 
            cd /tmp/bash-base
            tar -xf "$(basename ${1})" && rm "$(basename ${1})"
            if [[ -f "${2}/data" ]] && source "${2}/data" ; then
                echo "${bb_index}"
                cd ${bb_setdir}
                bb-temp-manager stop
                return 0
            else
                echo "${FUNCNAME}: Table '${2}' doesn't exist"
                cd ${bb_setdir}
                bb-temp-manager stop
                return 1
            fi
        else
            echo "${FUNCNAME}: Please specify the table name."
            return 1
        fi
    else
        echo "${FUNCNAME}: Please specify the base file as first parametre. Example: meraba-dunya.${bb_file_extention}"
        return 1
    fi

}

bb-list-tables() {
    # en fazla 1 (bir) parametreli fonksyon her kullanımda bir dosyanın içeriğini kontrol edilebilir
    # Örnek: bb-list-tables "meraba-dunya.bb"
    bb_setdir="${PWD}"
    if [[ $(file "${1}" | grep "gzip compressed data") ]]  ; then
        bb-temp-manager start
        cp "${1}" /tmp/bash-base 
        cd /tmp/bash-base
        tar -xf "$(basename ${1})" && rm "$(basename ${1})"
        # 1. ve sondan 2 satır boş.
        #find . -type d | sed 's/^.//' | tr -d "/"
        echo "-----------------------"
        ls -d ./* | sed 's/^.//' | tr "/" " "
        echo -e "-----------------------\nThere are '$(( $(ls | wc -l) - 1))' table(s)."
        cd ${bb_setdir}
        bb-temp-manager stop
        return 0
    else
        echo "${FUNCNAME}: Please specify the base file as first parametre. Example: meraba-dunya.${bb_file_extention}"
        return 1
    fi
}

bb-write-table() {
    bb_setdir="${PWD}"
    if [[ $(file "${1}" | grep "gzip compressed data") ]] ; then
        bb-temp-manager start
        cp "${1}" /tmp/bash-base 
        cd /tmp/bash-base
        tar -xf "$(basename ${1})" && rm "$(basename ${1})"
        source ./metadata
        if [[ -d "${2}" ]] ; then
            if [[ ! -z "${3}" ]] ; then
                echo "bb_index='${3}'" > "${2}/data"
                tar -czf "${bb_setdir}/${bb_setbasename}.${bb_file_extention}" ./*
                cd ${bb_setdir}
                return 0
            else
                echo "${FUNCNAME}: Please specify the new value to table of data '${2}'."
                cd ${bb_setdir}
                return 1
            fi
        else
            echo "${FUNCNAME}: Table '${2}' doesn't exist."
            cd ${bb_setdir}
            return 1
        fi
    else
        echo "${FUNCNAME}: Please specify the base file as first parametre. Example: meraba-dunya.${bb_file_extention}"
        return 1     
    fi
}