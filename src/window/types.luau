export type PixelStorageBuilder<P, T> = {
    new: () -> PixelStorage<P, T>,
}

export type PixelStorage<P, T> = {
    pixels: T,

    new: (sizeX: number, sizeY: number) -> PixelStorage<P, T>,

    Render: (self: PixelStorage<P, T>, image: EditableImage) -> (),
    Clear: (clearColor: P) -> (),
    Resize: (
        oldWidth: number,
        oldHeight: number,
        newWidth: number,
        newHeight: number
    ) -> (),
    ReadPixel: (x: number, y: number) -> P,
    WritePixel: (x: number, y: number, newColor: P) -> (),
}

return nil
