. bash-base.sh

if [[ ! -e ./meraba-dunya.bb ]] ; then
    bb-create-base "meraba-dunya"
fi

bb-create-tables "meraba-dunya.bb" "aa" "bb" "cc" "dd" "ee" "qq"

bb-list-tables "meraba-dunya.bb"

bb-check-table "meraba-dunya.bb" "aa"

bb-check-table "meraba-dunya.bb" "aAa"

bb-index-table "meraba-dunya.bb" "aa"

bb-write-table "meraba-dunya.bb" "aa" "merhaba dunya"

bb-index-table "meraba-dunya.bb" "aa"

bb-remove-tables "meraba-dunya.bb" "aa" "bb" "cc" "dd" "ee" "qq"