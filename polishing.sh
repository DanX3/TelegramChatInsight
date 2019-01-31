cat ChatExport*/messages* \
    | sed -E '/<\/?(div|a|body|html|head|script|meta|link|title)/d' \
    | sed '/^$/d' \
    | sed -E '/^[A-Z][A-Z]?\ ?$/d' \
    | sed -E '/^[A-Z][a-z]+\ [A-Z][a-z]+\ ?$/d' \
    | sed -E '/^[A-Z][a-z]+\ ?$/d' \
    | sed -E '/^(S<|Stalky &lt;3)\ ?$/d' \
    | sed -E '/[0-9]\ (K|M)B$/d' \
    | sed -E '/(Foto|Video)\ da/d' \
    | sed -E '/\.mp4$/d' \
    | sed -E '/^(Previous message|Next message|<!DOCTYPE html>)$/d' \
    | sed '/^Not\ included/d' \
    | sed '/[0-9][0-9]:[0-9][0-9]/d' \
    | sed '/via @gif/,+1 d' \
    | sed -E '/^(Photo|Animation)$/,+2 d' \
    | sed -E '/^(Location|Voice message|Video message|Video file)$/,+1 d' \
    | sed -E '/[0-9]+\ [A-Z][a-z]+\ [0-9]{4}/d' \
    | sed "s/&apos;/'/g" \
    | sed 's/&quot;/"/g' \
    > cleaned
