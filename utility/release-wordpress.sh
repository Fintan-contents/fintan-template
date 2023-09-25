#!/bin/bash
set -eux

function article2html {
    local destdir="${1?"missing dest dir"}"

    # exist same note number
    for md in article/[0-9][0-9][0-9][0-9]_*.md; do
        local html tmp_html
        html="${destdir}"/"$(basename "${md}")".html
        tmp_html="${destdir}"/"$(basename "${md}")"_tmp.html

        pandoc \
            --standalone \
            --resource-path=article \
            --metadata title="記事のタイトル" \
            --template=utility/html_templates/bootstrap_menu_wordpress.html \
            --fail-if-warnings \
            --wrap preserve \
            --output="${tmp_html}" \
            "${md}"

        # 他記事参照リンク書き換え TODO
        cat "${tmp_html}" | while read line
        do
        # articleNum=`echo $line | sed -e "s#\./[0-9][0-9][0-9][0-9]_.*\.md#" | sed -e "s#\./[0-9][0-9][0-9][0-9]#"
        # articleNum=`echo $line`
        echo "$line" | grep -E '\./[0-9]\{4,5\}_.*\.md'
        # articleNum=`echo $line | `
        # if grep -q -E "\./[0-9]\{4,5\}_.*\.md"; then
        # echo $line | sed -i -e "s#\./[0-9]\{4,5\}_.*\.md#/page/${articleNum}/#g" ${tmp_html}
        # fi
        done

        cat "${tmp_html}" |
            sed -e "s/<\!-- [^<>]+ -->//g" |
            sed -e "s/<h4/<h4 style=\\\"padding-top: 28px;border-bottom: 3px solid #eeeeee\\\"/g" |
            sed -e "s/<h5/<h5 style=\\\"font-size: 1em; margin-left: 10px; padding-top: 20px; border-bottom: 1px solid #eeeeee\\\"/g" |
            sed -e "s/<h6/<h6 style=\\\"font-size: 1em; padding-top: 10px;\\\"/g" >"${html}"
        rm "${tmp_html}"

        cat ${tmp_html}
    done

}

if [ "${1}" == "local" ]; then
    WORK_DIR=${2:-"test"}
    mkdir -p "$WORK_DIR"
    article2html "$WORK_DIR"
fi
