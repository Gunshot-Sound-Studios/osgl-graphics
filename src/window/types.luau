export type PixelStorageBuilder<P, T> = {
    new: () -> PixelStorage<P, T>,
}

export type PixelStorage<P, T> = {
    pixels: T,

    new: (sizeX: number, sizeY: number) -> PixelStorage<P, T>,

    Render: (self: PixelStorage<P, T>, image: EditableImage, size: Vector2) -> (),
    Clear: (self: PixelStorage<P, T>, clearColor: P) -> (),
    Resize: (
        self: PixelStorage<P, T>,
        oldWidth: number,
        oldHeight: number,
        newWidth: number,
        newHeight: number
    ) -> (),
    ReadPixel: (self: PixelStorage<P, T>, x: number, y: number, sizeX: number) -> P,
    WritePixel: (self: PixelStorage<P, T>, x: number, y: number, sizeX: number, newColor: P) -> (),
}

return nil
