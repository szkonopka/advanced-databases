import pandas as pd
import coffee_shop_entities as ents

data_base_path = '../data/base/'
data_processed_path = '../data/processed/'

csvs = [
    '201904_sales_reciepts',
    
    'dates', 
    'generations',
    'pastry_inventory',
    'product',
    'sales_outlet',
    'sales_targets',
    'customer',
    'staff'
]

tables = [
    'customer',
    'generation',
    'staff',
    'position',
    'product',
    'productGroup',
    'productCategory',
    'productType',
    'pastryInventory',
    'dates',
    'salesReciepts',
    'salesOutlet',
    'salesTarget',
    'salesOutletType'
]

source_to_table = {
    'customer' : 'customer',
    'customer' : 'generation',
    'staff' : 'staff',
    'position': 'staff',
} 

df = pd.read_csv(data_base_path + 'generations.csv')

df.apply(lambda row: ents.Generation(
    row['birth_year'], 
    row['generation'])
    .save_to_csv(data_processed_path + 'generation.csv'), axis = 1)

df = pd.read_csv(data_base_path + 'product.csv')

for elem in df['product_category'].unique():
    ents.ProductCategory(elem).save_to_csv(data_processed_path + 'productCategory.csv')

for elem in df['product_group'].unique():
    ents.ProductCategory(elem).save_to_csv(data_processed_path + 'productType.csv')

for elem in df['product_type'].unique():
    ents.ProductCategory(elem).save_to_csv(data_processed_path + 'productGroup.csv')

df.apply(lambda row: ents.Product(
    row['product_description'],
    row['current_wholesale_price'],
    row['current_retail_price'],
    1 if row['tax_exempt_yn'] == 'Y' else 0,
    1 if row['promo_yn'] == 'Y' else 0,
    1 if row['new_product_yn'] == 'Y' else 0,
    row['unit_of_measure'],
    0,
    0,
    0)
    .save_to_csv(data_processed_path + 'product.csv'), axis = 1)

df = pd.read_csv(data_base_path + 'staff.csv')

for elem in df['position'].unique():
    ents.Position(elem).save_to_csv(data_processed_path + 'position.csv')

df.apply(lambda row: ents.Staff(
    row['first_name'],
    row['last_name'],
    row['start_date'],
    row['location'],
    0)
    .save_to_csv(data_processed_path + 'staff.csv'), axis = 1)

df = pd.read_csv(data_base_path + 'sales_outlet.csv')

for elem in df['sales_outlet_type']:
    ents.SalesOutletType(elem).save_to_csv(data_processed_path + 'salesOutletType.csv')

df.apply(lambda row: ents.SalesOutlet(
    row['store_square_feet'],
    row['store_address'],
    row['store_city'],
    row['store_state_province'],
    row['store_telephone'],
    row['store_postal_code'],
    row['store_longitude'],
    row['store_latitude'],
    row['Neighorhood'],
    0,
    0
    )
    .save_to_csv(data_processed_path + 'salesOutlet.csv'), axis = 1)

df = pd.read_csv(data_base_path + 'sales_targets.csv')

df.apply(lambda row: ents.SalesTarget(
    row['year_month'],
    row['beans_goal'],
    row['beverage_goal'],
    row['food_goal'],
    row['merchandise_goal'],
    row['total_goal'],
    0)
    .save_to_csv(data_processed_path + 'salesTarget.csv'), axis = 1)

df = pd.read_csv(data_base_path + 'dates.csv')

df.apply(lambda row: ents.Dates(
    row['transaction_date'],
    row['Date_ID'],
    row['Week_ID'],
    row['Week_Desc'],
    row['Month_ID'],
    row['Month_Name'],
    row['Quarter_ID'],
    row['Quarter_Name'],
    row['Year_ID'])
    .save_to_csv(data_processed_path + 'dates.csv'), axis = 1)

df = pd.read_csv(data_base_path + 'pastry_inventory.csv')

df.apply(lambda row: ents.PastryInventory(
    row['transaction_date'],
    row['start_of_day'],
    row['quantity_sold'],
    row['waste'],
    row['% waste'],
    0,
    0)
    .save_to_csv(data_processed_path + 'pastryInventory.csv'), axis = 1)

df = pd.read_csv(data_base_path + '201904_sales_reciepts.csv')

df.apply(lambda row: ents.SalesReciepts(
    row['transaction_id'],
    row['transaction_time'],
    1 if row['instore_yn'] == 'Y' else 0,
    row['order'],
    row['line_item_id'],
    row['quantity'],
    row['line_item_amount'],
    row['unit_price'],
    1 if row['promo_item_yn'] == 'Y' else 0,
    0,
    0,
    0,
    0,
    0)
    .save_to_csv(data_processed_path + 'salesReciepts.csv'), axis = 1)
