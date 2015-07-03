require "parfait"
require "virtual/machine"
#if we are in the ruby run-time / generating an executable
require "virtual/positioned"
require "virtual/padding"
require "virtual/parfait_adapter"

require "virtual/compiler"
require "virtual/instruction"
require "virtual/method_source"
require "virtual/slots/slot"
require "virtual/type"
# the passes _are_ order dependant
require "virtual/passes/minimizer"
require "virtual/passes/collector"
require "virtual/passes/send_implementation"
require "virtual/passes/get_implementation"
require "virtual/passes/enter_implementation"
require "virtual/passes/set_optimisation"

Sof::Volotile.add(Parfait::Object ,  [:memory])
Sof::Volotile.add(Parfait::Method ,  [:memory])
Sof::Volotile.add(Parfait::Class ,  [:memory])
Sof::Volotile.add(Parfait::Layout ,  [:memory])
Sof::Volotile.add(Parfait::Space ,  [:memory])
Sof::Volotile.add(Parfait::Frame ,  [:memory])
Sof::Volotile.add(Parfait::Message ,  [:memory])
Sof::Volotile.add(Parfait::BinaryCode ,  [:memory])
Sof::Volotile.add(Virtual::Block ,  [:method])
Sof::Volotile.add(Virtual::MethodSource ,  [:current])

class Fixnum
  def fits_u8?
    self >= 0 and self <= 255
  end
end
