# bash-base
bash base is a simple text storage library, you can open tables in the data you save as a file and assign data to these tables, then you can easily recall, change or delete this data.

## Installation

Use the package manager [themis](https://github.com/ByCh4n-Group/themis) to install bash-base.

```bash
themis install bash-base
```
## Usage

```bash
. themis --source bash-base

if [[ ! -e ./meraba-dunya.bb ]] ; then
    bb-create-base "meraba-dunya" "aa"
fi

bb-create-tables "meraba-dunya.bb" "bb" "cc" "dd" "ee" "qq"

bb-list-tables "meraba-dunya.bb"

bb-check-table "meraba-dunya.bb" "aa"

bb-check-table "meraba-dunya.bb" "aAa"

bb-index-table "meraba-dunya.bb" "aa"

bb-write-table "meraba-dunya.bb" "aa" "merhaba dunya"

bb-index-table "meraba-dunya.bb" "aa"

bb-remove-tables "meraba-dunya.bb" "aa" "bb" "cc" "dd" "ee" "qq"
```

## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

Please make sure to update tests as appropriate.

## License
[GPL3](https://choosealicense.com/licenses/gpl-3.0/)
