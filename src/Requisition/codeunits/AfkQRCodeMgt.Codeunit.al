codeunit 50013 AfkQRCodeMgt
{
    procedure GenerateQRCode(TextData: Text): Text
    var
        BarcodeSymbology2D: Enum "Barcode Symbology 2D";
        BarcodeFontProvider2D: Interface "Barcode Font Provider 2D";
        BarcodeString: Text;
        QRCode: Text;
    begin
        BarcodeFontProvider2D := Enum::"Barcode Font Provider 2D"::IDAutomation2D;
        BarcodeSymbology2D := Enum::"Barcode Symbology 2D"::"QR-Code";
        BarcodeString := TextData;

        QRCode := BarcodeFontProvider2D.EncodeFont(BarcodeString, BarcodeSymbology2D);
        exit(QRCode);
    end;
}
