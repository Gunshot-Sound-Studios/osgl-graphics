local OSGL = require(script.Parent.OSGL)
local types = OSGL.types

return function(width: number, height: number, pixels: { types.Color }): string
    local last_color = pixels[1]
    local repetitions = 0
    local module_text = "return {\n\t"
        .. `width = \{{width}},\n\t`
        .. `height = \{{height}},\n\t`
        .. "pixels = {"

    for _, color in ipairs(pixels) do
        if color == last_color then
            repetitions += 1

            continue
        end

        if repetitions > 1 then
            module_text ..= `"r{repetitions}-{last_color}",`
            repetitions = 0
        elseif repetitions == 0 then
            module_text ..= tostring(last_color)
            repetitions = 0
        end

        last_color = color
        repetitions += 1
    end

    if repetitions ~= 0 then
        module_text ..= `"r{repetitions}-{last_color}"`
    end

    return `{module_text}},\n}`
end
