require 'faker'
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Warehouse::FacilityType.create! id: 0, code: 'UNIDENTIFIED', display_name: 'UNIDENTIFIED'
Warehouse::Facility.create! id: 0, code: 'UNIDENTIFIED', display_name: 'UNIDENTIFIED'
supplier_default = Supplier::Supplier.create! id: 0, company_code: 'UNIDENTIFIED', display_name: 'UNIDENTIFIED'
freight_provider_default = Freight::Provider.create! id: 0, name: 'UNIDENTIFIED'

bank_seeds = [
  { id: 0, code: 'UNIDENTIFIED', display_name: 'UNIDENTIFIED' },
  { code: 'BBL', display_name: 'ธนาคารกรุงเทพ' },
  { code: 'BAY', display_name: 'ธนาคารกรุงศรีอยุธยา' },
  { code: 'KBANK', display_name: 'ธนาคารกสิกรไทย' },
  { code: 'KTB', display_name: 'ธนาคารกรุงไทย' },
  { code: 'TMB', display_name: 'ธนาคารทหารไทย' },
  { code: 'SCB', display_name: 'ธนาคารไทยพาณิชย์' },
  { code: 'GSB', display_name: 'ธนาคารออมสิน' },
  { code: 'ฺBACC', display_name: 'ธนาคารเพื่อการเกษตรและสหกรณ์การเกษตร' },
  { code: 'KKP', display_name: 'ธนาคารเกียรตินาคิน' },
  { code: 'TCAP', display_name: 'ธนาคารธนชาต' },
  { code: 'CIMBT', display_name: 'ธนาคารซีไอเอ็มบีไทย' },
  { code: 'TISCO', display_name: 'ธนาคารทิสโก้' },
  { code: 'UOB', display_name: 'ธนาคารยูโอบี' },
  { code: 'LHBANK', display_name: 'ธนาคารแลนด์ แอนด์ เฮาส์' },
  { code: 'SC', display_name: 'ธนาคารสแตนดาร์ดชาร์เตอร์ด (ไทย)' },
  { code: 'GHB', display_name: 'ธนาคารอาคารสงเคราะห์' },
  { code: 'IBANK', display_name: 'ธนาคารอิสลามแห่งประเทศไทย' },
  { code: 'ICBC', display_name: 'ธนาคารไอซีบีซี (ไทย)' }
]

bank_seeds.map { |e| Accounting::Bank.create! e }

# development seeds
if Rails.env.eql? 'development'
  puts '################## development seed ##################'
  admin = Staff.new email: 'admin@example.com', first_name: 'admin', last_name: 'dave', employee_code: '0001', nickname: 'admin', password: 'qwerty1234', staff_account: 'admin'
  admin.add_role :modorator
  admin.save!

  warehouse = Staff.new email: 'warehouse@example.com', first_name: 'warehouse', last_name: 'dave', employee_code: '0002', nickname: 'warehouse', password: 'qwerty1234', staff_account: 'warehouse'
  warehouse.add_role :warehouse
  warehouse.save!

  sale = Staff.new email: 'sale@example.com', first_name: 'sale', last_name: 'dave', employee_code: '0003', nickname: 'sale', password: 'qwerty1234', staff_account: 'sale'
  sale.add_role :sale
  sale.save!

  accounting = Staff.new email: 'accounting@example.com', first_name: 'accounting', last_name: 'dave', employee_code: '0004', nickname: 'accountant', password: 'qwerty1234', staff_account: 'accounting'
  accounting.add_role :accountant
  accounting.save!

  # Bank Seeds
  bank_branch = Accounting::BankBranch.create! display_name: 'Brach Dave - 001', bank: Accounting::Bank.second
  3.times { |n| Accounting::CompanyBankAccount.create! code: "022123450#{n}", display_name: "Account - #{n}", bank_branch: bank_branch }

  # Inventory Seeds
  2.times { |n| Inventory::InventoryItem.create! supplier_sku: "supplier-#{n}", display_name: Faker::Commerce.product_name, supplier: supplier_default }
  puts '################## End development seed ##################'
end
