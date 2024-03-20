
function get_link_data(element, attr_name)
    link_data = HTML.get_attribute(element,attr_name)

    if not link_data then
        link_data = format("%s with attr %s not exists", element, attr_name)
    end

    return link_data
end

function get_element_of_meta(element)
    local env = {}
    env["field"] = get_link_data(element,"field")
    env["type"] =  get_link_data(element, "type")
    env["audience"] =  get_link_data(element,"audience")
    env["tags"] = get_link_data(element, "tags")
    env["date"] = get_link_data(element, "date")
    return env
end

if not Sys.is_file("templates/seed-meta.html") then
    Plugin.fail("seed-meta.html not found in template folder.")
end

meta_table_template = Sys.read_file("templates/seed-meta.html")

elements = HTML.select_one(page, "seed-meta")

local index = 1
if elements then 
    elem = elements
    html_tag = HTML.get_tag_name(elem)
    if (html_tag == "seed-meta") then
        local env = get_element_of_meta(elem)
        new_elem = String.render_template(meta_table_template,env)
    end

    if new_elem then
        HTML.replace(elem, HTML.parse(new_elem))
    else
        HTML.delete(elem)
    end
end