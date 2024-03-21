
local field_tag = HTML.select_one(page,"span#seed-field")
local tags_tag = HTML.select_one(page,"span#seed-tags")

if field_tag then
    local field = HTML.strip_tags(field_tag)
    local field_link = format("<a href=\"/field/%s\">%s</a>",field, field)

    HTML.replace(field_tag,HTML.parse(field_link))
end

if tags_tag then 
    local tags_links = ""
    local tags = Regex.split(HTML.strip_tags(tags_tag), ",")

    print(tags)

    local i = 1
    while i <= size(tags) do
        tags_links = tags_links .. format("<a href=\"/tag/%s\">%s</a>",tags[i],tags[i]) 
        if not(i == size(tags)) then
            tags_links = tags_links .. "  &ensp; "
        end
        i = i + 1
    end
    HTML.replace(tags_tag,HTML.parse(tags_links))
end


