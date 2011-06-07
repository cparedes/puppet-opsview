Puppet::Type.newtype(:opsview_contact) do
  @doc = "Manages contacts in an Opsview monitoring system"

  ensurable

  newparam(:name, :namevar => true) do
  end
  newparam(:reload_opsview) do
    desc "True if you want an Opsview reload to be performed when the
      contact is updated"
  end
  newproperty(:fullname) do
    desc "Full name of the user"
  end
  newproperty(:description) do
    desc "Short description for the contact"
  end
  newproperty(:role) do
    desc "The role that the user is in.  Defaults are:
      Administrator
      View all, change none
      View all, change some
      View some, change none
      View some, change some"
  end
  newproperty(:encrypted_password) do
    desc "The user's encrypted password.  Defaults to \"password\" if not
      specified."
  end
  newproperty(:language) do
    desc "The user's language"
  end
  newproperty(:email) do
    desc "Email address for the user."
  end
  # HACK: These two hostgroups* properties are hard-coded into this provider
  #       since we can't manage notificationprofile objects via the API.
  #       This is the best option I could come up with for now, and we only
  #       use these two profile types(8x5 and 24x7), so it should work.
  newproperty(:hostgroups8x5, :array_matching => :all) do
    desc "An array of hostgroups for the 8x5 notification profile."
  end
  newproperty(:hostgroups24x7, :array_matching => :all) do
    desc "An array of hostgroups for the 24x7 notification profile."
  end
  newproperty(:allhostgroups8x5, :boolean => true) do
    desc "A boolean defining whether or not all hostgroups will have 8x5
      notifications for this contact."
    defaultto [false]
    munge do |value|
      if value == true
        value = "1"
      elsif value == false
        value = "0"
      end
    end
  end
  newproperty(:allhostgroups24x7, :boolean => true) do
    desc "A boolean defining whether or not all hostgroups will have 24x7
      notifications for this contact."
    defaultto [false]
    munge do |value|
      if value == true
        value = "1"
      elsif value == false
        value = "0"
      end
    end
  end
  
  autorequire(:opsview_hostgroup) do
    hostgroups = []
    if not self[:hostgroups8x5].to_s.empty?
      hostgroups += self[:hostgroups8x5]
    end
    if not self[:hostgroups24x7].to_s.empty?
      hostgroups += self[:hostgroups24x7]
    end
    hostgroups
  end
  autorequire(:opsview_role) do
    [self[:role]]
  end
end
