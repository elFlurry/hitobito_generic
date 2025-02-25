
module Generic::Export::Tabular::People::PeopleFull
  extend ActiveSupport::Concern

  included do
    alias_method_chain :person_attributes, :payment_fields_and_tags
  end

  def person_attributes_with_payment_fields_and_tags
    person_attributes_without_payment_fields_and_tags - 
      [:payment_method, :iban, :bic, :account_holder] + 
      [:tags, :translated_payment_method, :iban, :bic, :account_holder]
  end
end



# # encoding: utf-8

# #  Copyright (c) 2012-2017, Jungwacht Blauring Schweiz. This file is part of
# #  hitobito and licensed under the Affero General Public License version 3
# #  or later. See the COPYING file at the top-level directory or at
# #  https://github.com/hitobito/hitobito.

# module Export::Tabular::People
#   class PeopleFull < PeopleAddress

#     def person_attributes
#       Person.column_names.collect(&:to_sym) -
#         Person::INTERNAL_ATTRS -
#         [:picture, :primary_group_id, :id] +
#         [:layer_group, :roles]
#     end

#     def association_attributes
#       account_labels(people.map(&:additional_emails).flatten, AdditionalEmail).merge(
#         account_labels(people.map(&:phone_numbers).flatten, PhoneNumber)
#       ).merge(
#         account_labels(people.map(&:social_accounts).flatten, SocialAccount)
#       ).merge(
#         qualification_kind_labels
#       ).merge(
#         relation_kind_labels
#       )
#     end

#     def relation_kind_labels
#       different_kinds = people.map(&:relations_to_tails).flatten.collect(&:kind).uniq
#       different_kinds.each_with_object({}) do |kind, obj|
#         if kind.present?
#           obj[:"people_relation_#{kind}"] = PeopleRelation.new(kind: kind).translated_kind
#         end
#       end
#     end

#     def qualification_kind_labels
#       qualification_kinds = people.flat_map do |p|
#         p.qualifications.map { |q| q.qualification_kind.label }
#       end
#       qualification_kinds.uniq.sort.each_with_object({}) do |label, obj|
#         if label.present?
#           obj[ContactAccounts.key(QualificationKind, label)] = label
#         end
#       end
#     end

#   end
# end
