enum 50012 AfkPRDeliveryStatus
{
    Extensible = true;
    
    value(0; " ")
    {
        Caption = ' ';
    }
    value(1; Awaiting)
    {
        Caption = 'Awaiting Delivery';
    }
    value(2; Partially)
    {
        Caption = 'Partially Delivery';
    }
    value(3; Completed)
    {
        Caption = 'Completely Delivery';
    }
}
