-- This is the configuration file for OSGL, it allows you to enable/disable features
-- as well as change some aspects of the library so it works best for your use case.
--
-- Realtime changes to this file will have no effect on the library, any edits must be
-- done before OSGL is initialized (aka `require`d); thus it isn't re-xported. Edit it
-- manually before running the game.

return {
    -- Whether or not to use `buffer` as the pixel storage for the window. This uses
    -- `EditableImage:WritePixelsBuffer`, which is currently locked behind a FFlag.
    -- If you have the FFlag enabled, you should enable this configuration, if not
    -- keep it off to avoid errors.
    --
    -- Enabling this provides a huge performance boost almost 2x as fast as the default
    -- storage.
    useBufferPixelStorage = false
}
