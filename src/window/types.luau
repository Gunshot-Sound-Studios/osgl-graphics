export type PixelStorageBuilder<P> = {
    new: (sizeX: number, sizeY: number) -> PixelStorage<P>,
}

export type PixelStorage<P> = {
    Render: (self: PixelStorage<P>, image: EditableImage, size: Vector2) -> (),
    Clear: (self: PixelStorage<P>, clearColor: P) -> (),
    Resize: (
        self: PixelStorage<P>,
        oldWidth: number,
        oldHeight: number,
        newWidth: number,
        newHeight: number
    ) -> (),
    ReadPixel: (self: PixelStorage<P>, x: number, y: number, sizeX: number) -> P,
    WritePixel: (self: PixelStorage<P>, x: number, y: number, sizeX: number, newColor: P) -> (),
}

return nil
