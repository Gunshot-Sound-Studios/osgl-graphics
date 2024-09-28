local utils = {}

function utils.lerp(n1: number, n2: number, factor: number): number
    return math.floor((1 - factor) * n1 + factor * n2)
end

return utils
