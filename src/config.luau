-- This is the configuration file for OSGL, it allows you to enable/disable features
-- as well as change some aspects of the library so it works best for your use case.
--
-- Realtime changes to this file will have no effect on the library, any edits must be
-- done before OSGL is initialized (aka `require`d); thus it isn't re-xported. Edit it
-- manually before running the game.

return {
    -- Whether or not to use `buffer` as the pixel storage for the window. This uses
    -- `EditableImage:WritePixelsBuffer`, which was locked behind a FFlag. Currently,
    -- it isn't. The option is still here in acse someone doesn't want to use it. Will
    -- be removed in the future!
    --
    -- Enabling this provides a huge performance boost almost 2x as fast as the default
    -- storage.
    useBufferPixelStorage = true
}
