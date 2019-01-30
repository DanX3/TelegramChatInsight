cat ChatExport*/messages* \
    | sed -E '/<\/?(div|a|body|html|head|script|meta|link|title)/d' \
    | sed -E '/(D|Daniele |S<|Stalky &lt;3|Previous messages|Next messages|<!DOCTYPE html>)$/d' \
    | sed '/^$/d' \
    | sed '/[0-9][0-9]:[0-9][0-9]/d' \
    | sed '/via @gif/,+3 d' \
    | sed -E '/^(Sticker|Photo|Animation)$/,+2 d' \
    | sed -E '/^(Location|Voice message|Video message|Video file)$/,+1 d' \
    | sed -E '/[0-9]+\ [A-Z][a-z]+\ [0-9]{4}/d' \
    | sed "s/&apos;/'/g" \
    | sed 's/&quot;/"/g' \
    > polished
