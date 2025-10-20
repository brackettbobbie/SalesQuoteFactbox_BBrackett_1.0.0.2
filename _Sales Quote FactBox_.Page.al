page 50100 "Sales Quote FactBox"
{
    Caption = 'Associated Quotes';
    PageType = CardPart;
    SourceTable = "Sales Line";
    AboutTitle = 'Associated Quotes';
    AboutText = 'Shows quotes for selected Item for this Customer';

    layout
    {
        area(content)
        {
            field(LastUnitPrice; cduFuncs.FindLastInvoicedPrice(Rec."Bill-to Customer No.", Rec."No."))
            {
                ApplicationArea = all;
                Caption = 'Last Invoiced Price';

                trigger OnDrillDown()
                var
                    SalesInvLine: Record "Sales Invoice Line";
                begin
                    SalesInvLine.SetRange("Bill-to Customer No.", Rec."Bill-to Customer No.");
                    SalesInvLine.SetRange("No.", Rec."No.");
                    if SalesInvLine.FindFirst()then Page.RunModal(Page::"Posted Sales Invoice Lines", SalesInvLine);
                end;
            }
            field(LastestQuote; cduFuncs.FindLastQuote(Rec."Sell-to Customer No.", Rec."No."))
            {
                ApplicationArea = all;
                Caption = 'Latest Quote';

                trigger OnDrillDown()
                var
                    SalesQuoteExpiryDate: Record "Sales Header";
                    SalesQuoteLine: Record "Sales Line";
                    TheLatestQuote: Code[20];
                begin
                    TheLatestQuote:=cduFuncs.FindLastQuote(Rec."Sell-to Customer No.", Rec."No.");
                    SalesQuoteExpiryDate.SetRange("No.", TheLatestQuote);
                    SalesQuoteExpiryDate.SetRange("Document Type", 0);
                    if SalesQuoteExpiryDate.FindLast()then Page.RunModal(Page::"Sales Quote", SalesQuoteExpiryDate);
                /*                    SalesQuoteLine.SetRange("Sell-to Customer No.", Rec."Sell-to Customer No.");
                                        SalesQuoteLine.SetRange("No.", Rec."No.");
                                        SalesQuoteLine.SetRange("Document Type", 0);
                                        if SalesQuoteLine.FindFirst() then
                                            Page.RunModal(Page::"Sales Quote Subform", SalesQuoteLine);
                    */
                end;
            }
        /*
                        field(QuoteExpiryDate; cduFuncs.FindQuoteExpiryDate(rec."Document No."))
                        {
                            ApplicationArea = all;
                            Caption = 'Quote Expiry Date';

                            trigger OnDrillDown()
                            var
                                SalesQuoteExpiryDate: Record "Sales Header";
                                SalesQuoteLine: Record "Sales Line";
                                TheLatestQuote: Code[20];
                            begin
                                TheLatestQuote := cduFuncs.FindLastQuote(Rec."Sell-to Customer No.", Rec."No.");
                                SalesQuoteExpiryDate.SetRange("No.", TheLatestQuote);
                                SalesQuoteExpiryDate.SetRange("Document Type", 0);
                                if SalesQuoteExpiryDate.FindLast() then
                                    Page.RunModal(Page::"Sales Quote", SalesQuoteExpiryDate);
                            end;

                        }
            */
        }
    }
    var cduFuncs: Codeunit "Functions";
}
