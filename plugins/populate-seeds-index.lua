if not config["index_template"] then
    Plugin.fail("Please define the index_template option")
end

-- this tag by field
paths = {}
paths["field"] = Sys.join_path(Sys.dirname(page_file),"field")
paths["type"] = Sys.join_path(Sys.dirname(page_file), "type")
paths["audience"] = Sys.join_path(Sys.dirname(page_file), "audience")
paths["tags"] = Sys.join_path(Sys.dirname(page_file), "tag")

pages = {}

-- This to collect all value in field.
-- this had todo with hooks.post-index in soupault.toml
function aggregate_value_of_index_field(index_field)
    local all = {}
    local i = 1
    local count = size(site_index)
    while (i <= count) do
        local entry = site_index[i]
        local k = 1
        if not entry[index_field] then
            -- This entry has no tags, skip it
            i = i + 1
        else
            field_count = size(entry[index_field])
            while (k <= field_count) do
                all[entry[index_field][k]] = 1
                k = k + 1
            end
        end
        i = i + 1
    end
    all = Table.keys(all)
    return all
end

function find_entries_with_index_field(entries,index_field, value)
    local es = {}
    local i = 1
    Log.debug("so far")
    local count = size(entries)
    local k = 1
    while (i <= count) do
      entry = entries[i]
      if not (Value.is_table(entry[index_field])) then
        -- No tags in this entry, so it definitely does not match
        i = i + 1
      else
        if Table.has_value(entry[index_field], value) then
          es[k] = entry
          k = k + 1
        end
        i = i + 1
      end
    end
    return es
end

-- this function to inflate all matched url with index_template
function build_index_field_page(entries, index_field, value)
    local match_entries = find_entries_with_index_field(entries,index_field,value)
    local template = "<h1> Seed with {{index_field}} \"{{value}}\" </h1> " .. config["index_template"]
    local env = {}
    env["index_field"] = index_field
    env["value"] = value
    env["entries"] = match_entries
    -- remember to use for-loop to consume entries
    seeds = String.render_template(template,env)
    return seeds
end

function build_index_field_catalog_page(entries, index_field)
    local all_index_field = aggregate_value_of_index_field(index_field)
    local template_index = [[
        <section class="seed-index-entries">
        {% for v in values %}
            <p class="border-bottom: 1px dashed #859388;"><a href="/{{index_field}}/{{v}}">{{v}}</a></p>
        {% endfor %}
        </section>
    ]]
    local template = "<h1> {{index_field}}'s catalog </h1> " .. template_index
    local env = {}
    env["index_field"] = index_field
    env["values"] = all_index_field
    -- remember to use for-loop to consume entries
    seeds = String.render_template(template,env)
    return seeds
end

function generate_page_by_index_field(index_field)
    local i = 1
    local all_index_field = aggregate_value_of_index_field(index_field)
    local index_field_count = size(all_index_field)
    while (i <= index_field_count) do
        entry = all_index_field[i]
        if entry then
            Log.info(format("Generating a page for %s \"%s\"",index_field,entry))
            field_page = {}
            field_page["page_file"] = Sys.join_path(paths[index_field],format("%s.html",entry))
            field_page["page_content"] = build_index_field_page(site_index,index_field,entry)

            pages[size(pages) + 1] = field_page
        end

        i = i + 1
    end
end

function generate_catalog_by_index_field(index_field)
    local field_catalog = {}
    field_catalog["page_file"] = Sys.join_path(paths[index_field],"index.html")
    field_catalog["page_content"] = build_index_field_catalog_page(site_index,index_field)
    pages[size(pages) + 1] = field_catalog
end

generate_page_by_index_field("audience")
generate_page_by_index_field("field")
generate_page_by_index_field("tags")
generate_page_by_index_field("type")

generate_catalog_by_index_field("audience")
generate_catalog_by_index_field("field")
generate_catalog_by_index_field("type")

print(site_index)