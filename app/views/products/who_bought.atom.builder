atom_feed do |feed|
    feed.title "Who bought #{@product.title}"

    feed.updated @latest_order.try(:updated_at)

    @product.orders.each do |order|
        feed.entry(order) do |entry|
            entry.tittle "Order #{order.id}"
            entry.summary type: 'xhtml' do |xhtml|
                xhtml.p "Shipped to #{order.address}"

                xhtml.table do
                    xhtml.tr do
                        xhtml.th 'Product'
                        xhtml.th 'Quantity'
                        xhtml.th 'Total Price'
                    end

                    order.line_item.each do |item|
                        xhtml.td item.product.title
                        xhtml.td item.quantity
                        xhtml.td number_tu_currency item.total_price
                    end
                end

                xhtml.p "Paid by #{order.pay_type}"
            end

            entry.author do |author|
                author.name order.name
                author.email order.email
            end
        end
    end
end
