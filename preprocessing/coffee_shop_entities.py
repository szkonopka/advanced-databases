import pandas as pd

def file_need_to_be_created(filename):
    try:
        f = open(filename)
        return False
    except FileNotFoundError:
        return True

class Entity:
    def save_to_csv(self, filename):
        df = pd.DataFrame(self.__dict__, columns = list(self.__dict__.keys()), index=[0])
        df.to_csv(filename, index=False, mode='a', header=file_need_to_be_created(filename))

class Customer(Entity):
    def __init__(
            self,
            firstName,
            email,
            since,
            loyaltyCardNumber,
            birthdate,
            homeStore,
            birthYear
        ):
        self.firstName = firstName
        self.email = email
        self.since = since
        self.loyaltyCardNumber = loyaltyCardNumber
        self.birthdate = birthdate
        self.homeStore = homeStore
        self.birthYear = birthYear

class Generation(Entity): 
    def __init__(
            self,
            birthYear,
            generationName
        ):
        self.birthYear = birthYear
        self.generationName = generationName

class Staff(Entity):
    def __init__(
            self,
            firstName,
            lastName,
            startDate,
            location,
            position
        ):
        self.firstName = firstName
        self.lastName = lastName
        self.startDate = startDate
        self.location = location
        self.position = position

class Position(Entity):
    def __init__(
            self,
            name
        ):
        self.name = name

class ProductGroup(Entity):
    def __init__(
            self,
            group
        ):
        self.group = group

class ProductCategory(Entity):
    def __init__(
            self,
            category
        ):
        self.category = category

class ProductType(Entity):
    def __init__(
            self,
            type
        ):
        self.type = type

class Product(Entity):
    def __init__(
            self,
            description,
            currentWholesalePrice,
            currentRetailPrice,
            taxExempt,
            promo,
            newProduct,
            unitOfMeasure,
            productGroup,
            productCategory,
            productType
        ):
        self.description = description
        self.currentWholesalePrice = currentWholesalePrice
        self.currentRetailPrice = currentRetailPrice
        self.taxExempt = taxExempt
        self.promo = promo
        self.newProduct = newProduct
        self.unitOfMeasure = unitOfMeasure
        self.productGroup = productGroup
        self.productCategory = productCategory
        self.productType = productType

class PastryInventory(Entity):
    def __init__(
            self,
            transactionDate,
            startOfDay,
            quantitySold,
            waste,
            wastePercentage,
            salesOutlet,
            product
        ):
        self.transactionDate = transactionDate
        self.startOfDay = startOfDay
        self.quantitySold = quantitySold
        self.waste = waste
        self.wastePercentage = wastePercentage
        self.salesOutlet = salesOutlet
        self.product = product

class Dates(Entity):
    def __init__(
            self,
            transactionDate,
            dateId,
            weekId,
            weekDescription,
            monthId,
            monthName,
            quarterId,
            quarterName,
            yearId
        ):
        self.transactionDate = transactionDate
        self.dateId = dateId
        self.weekId = weekId
        self.weekDescription = weekDescription
        self.monthId = monthId
        self.monthName = monthName
        self.quarterId = quarterId
        self.quarterName = quarterName
        self.yearId = yearId

class SalesReciepts(Entity):
    def __init__(
            self,
            transactionId,
            transactionTime,
            inStore,
            order,
            lineItemId,
            quantity,
            lineItemAmount,
            unitPrice,
            promo,
            transactionDate,
            salesOutlet,
            staff,
            customer,
            product
        ):
        self.transactionId = transactionId
        self.transactionTime = transactionTime
        self.inStore = inStore
        self.order = order
        self.lineItemId = lineItemId
        self.quantity = quantity
        self.lineItemAmount = lineItemAmount
        self.unitPrice = unitPrice
        self.promo = promo
        self.transactionDate = transactionDate
        self.salesOutlet = salesOutlet
        self.staff = staff
        self.customer = customer
        self.product = product

class SalesOutlet(Entity):
    def __init__(
            self,
            storeSquareFeet,
            storeAddress,
            storeCity,
            storeProvince,
            storeTelephone,
            storePostalCode,
            storeLangitude,
            storeLatitude,
            neighborhood,
            salesOutletType,
            manager
        ):
        self.storeSquareFeet = storeSquareFeet
        self.storeAddress = storeAddress
        self.storeCity = storeCity
        self.storeProvince = storeProvince
        self.storeTelephone = storeTelephone
        self.storePostalCode = storePostalCode
        self.storeLangitude = storeLangitude
        self.storeLatitude = storeLatitude
        self.neighborhood = neighborhood
        self.salesOutletType = salesOutletType
        self.manager = manager

class SalesOutletType(Entity):
    def __init__(
            self,
            type
        ):
        self.type = type

class SalesTarget(Entity):
    def __init__(
            self,
            yearMonthDate,
            beansGoal,
            beverageGoal,
            foodGoal,
            merchandiseGoal,
            totalGoal,
            salesOutlet
        ):
        self.yearMonthDate = yearMonthDate
        self.beansGoal = beansGoal
        self.beverageGoal = beverageGoal
        self.foodGoal = foodGoal
        self.merchandiseGoal = merchandiseGoal
        self.totalGoal = totalGoal
        self.salesOutlet = salesOutlet