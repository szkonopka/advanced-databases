import pandas as pd
import coffee_shop_entities as ents
import math

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

storage = {}

df = pd.read_csv(data_base_path + 'generations.csv')

df.apply(lambda row: ents.Generation(
    row['birth_year'], 
    row['generation'])
    .save_to_csv(data_processed_path + 'generation.csv'), axis = 1)

df = pd.read_csv(data_base_path + 'product.csv')

storage['productCategory'] = {}
for index, elem in enumerate(df['product_category'].unique(), start=1):
    pc = ents.ProductCategory(index, elem)
    storage['productCategory'][elem] = pc
    pc.save_to_csv(data_processed_path + 'productCategory.csv')

storage['productGroup'] = {}
for index, elem in enumerate(df['product_group'].unique(), start=1):
    pg = ents.ProductGroup(index, elem)
    storage['productGroup'][elem] = pg
    pg.save_to_csv(data_processed_path + 'productGroup.csv')

storage['productType'] = {}
for index, elem in enumerate(df['product_type'].unique(), start=1):
    pt = ents.ProductType(index, elem)
    storage['productType'][elem] = pt
    pt.save_to_csv(data_processed_path + 'productType.csv')

df.apply(lambda row: ents.Product(
    row['product_id'],
    row['product_description'],
    str(row['current_wholesale_price']).replace('.', ',').replace('$', '').replace(' ', ''),
    str(row['current_retail_price']).replace('.', ',').replace('$', '').replace(' ', ''),
    1 if row['tax_exempt_yn'] == 'Y' else 0,
    1 if row['promo_yn'] == 'Y' else 0,
    1 if row['new_product_yn'] == 'Y' else 0,
    row['unit_of_measure'],
    storage['productGroup'][row['product_group']].id,
    storage['productCategory'][row['product_category']].id,
    storage['productType'][row['product_type']].id)
    .save_to_csv(data_processed_path + 'product.csv'), axis = 1)

df = pd.read_csv(data_base_path + 'staff.csv')

storage['position'] = {}
for index, elem in enumerate(df['position'].unique(), start=1):
    p = ents.Position(index, elem)
    storage['position'][elem] = p
    p.save_to_csv(data_processed_path + 'position.csv')

df.apply(lambda row: ents.Staff(
    row['staff_id'],
    row['first_name'],
    row['last_name'],
    row['start_date'],
    row['location'],
    storage['position'][row['position']].id)
    .save_to_csv(data_processed_path + 'staff.csv'), axis = 1)

df = pd.read_csv(data_base_path + 'sales_outlet.csv')

storage['salesOutletType'] = {}
for index, elem in enumerate(df['sales_outlet_type'].unique(), start=1):
    sot = ents.SalesOutletType(index, elem)
    storage['salesOutletType'][elem] = sot
    sot.save_to_csv(data_processed_path + 'salesOutletType.csv')

df.apply(lambda row: ents.SalesOutlet(
    row['sales_outlet_id'],
    row['store_square_feet'],
    row['store_address'],
    row['store_city'],
    row['store_state_province'],
    row['store_telephone'].replace('-', ''),
    row['store_postal_code'],
    str(row['store_longitude']).replace('.', ','),
    str(row['store_latitude']).replace('.', ','),
    row['Neighorhood'],
    storage['salesOutletType'][row['sales_outlet_type']].id,
    int(row['manager']) if not math.isnan(row['manager']) else '')
    .save_to_csv(data_processed_path + 'salesOutlet.csv'), axis = 1)

df = pd.read_csv(data_base_path + 'sales_targets.csv')

df.apply(lambda row: ents.SalesTarget(
    row['year_month'],
    row['beans_goal'],
    row['beverage_goal'],
    row['food_goal'],
    row['merchandise_goal'],
    row['total_goal'],
    row['sales_outlet_id'])
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
    row['% waste'].replace('%', '').replace(' ', ''),
    row['sales_outlet_id'],
    row['product_id'])
    .save_to_csv(data_processed_path + 'pastryInventory.csv'), axis = 1)

df = pd.read_csv(data_base_path + 'customer.csv')

df.apply(lambda row: ents.Customer(
    row['customer_id'],
    row['customer_first-name'],
    row['customer_email'],
    row['customer_since'],
    row['loyalty_card_number'],
    row['birthdate'],
    row['gender'],
    row['home_store'],
    row['birth_year'])
    .save_to_csv(data_processed_path + 'customer.csv'), axis = 1)

df = pd.read_csv(data_base_path + '201904_sales_reciepts.csv')

df.apply(lambda row: ents.SalesReciepts(
    row['transaction_id'],
    row['transaction_time'],
    1 if row['instore_yn'] == 'Y' else 0,
    row['order'],
    row['line_item_id'],
    row['quantity'],
    str(row['line_item_amount']).replace('.', ','),
    str(row['unit_price']).replace('.', ','),
    1 if row['promo_item_yn'] == 'Y' else 0,
    row['transaction_date'],
    row['sales_outlet_id'],
    row['staff_id'],
    row['customer_id'],
    row['product_id'])
    .save_to_csv(data_processed_path + 'salesReciepts.csv'), axis = 1)