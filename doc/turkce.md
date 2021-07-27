# bash-base
bash base basit bir metin depolama kitaplığıdır, dosya olarak kaydettiğiniz verilerde tablolar açıp bu tablolara veri atayabilir, ardından bu verileri kolayca geri çağırabilir, değiştirebilir veya silebilirsiniz.

## Kurulum

bash-base'i kurmak için [themis](https://github.com/ByCh4n-Group/themis) projesini kullanabilirsiniz.

```bash
~# themis install bash-base
```

## Kullanum

```bash
. themis --source bash-base

if [[ ! -e ./meraba-dunya.bb ]] ; then
    bb-create-base "meraba-dunya" "aa"
fi

bb-create-tables "meraba-dunya.bb" "aa" "bb" "cc" "dd" "ee" "qq"

bb-list-tables "meraba-dunya.bb"

bb-check-table "meraba-dunya.bb" "aa"

bb-check-table "meraba-dunya.bb" "aAa"

bb-index-table "meraba-dunya.bb" "aa"

bb-write-table "meraba-dunya.bb" "aa" "merhaba dunya"

bb-index-table "meraba-dunya.bb" "aa"

bb-remove-tables "meraba-dunya.bb" "aa" "bb" "cc" "dd" "ee" "qq"
```

## Katkıda bulunma
Çekme istekleri kabul edilir. Büyük değişiklikler için lütfen önce neyi değiştirmek istediğinizi tartışmak için bir konu açın>

Lütfen testleri uygun şekilde güncellediğinizden emin olun.

## Lisans
[GPL3](https://choosealicense.com/licenses/gpl-3.0/)
